#include "./Reader.h"

#include <functional>
#include "../Library/Library.h"

void Reader::Run(threading::Barrier* sync_time_barrier, size_t work_time)
{
    sync_time_barrier->Wait(); // Wait for all readers and the library to start
    this->epoch = clock::now(); // Save the current time - the time when everything starts
    while (clock::now() - this->epoch <= std::chrono::seconds(work_time)) // while the reader has not been active long enough, it should continue
    {
        this->actions_access.Lock(); // Lock the access to the actions queue
        if (this->actions.empty() || this->actions.top().time >= clock::now() - this->epoch) { this->actions_access.Unlock(); continue; } // If there are no actions to handle, unlock the access to the queue and proceed to the next iteration
        Action action = this->actions.top(); // Get the first action in the queue
        this->actions.pop(); // Remove the first action from the queue
        this->actions_access.Unlock(); // Unlock the access to the queue

        switch (action.GetType()) // Check the type of the event
        {
            case Action::Type::TAKE: { std::get<Library*>(action.executor)->EnqueueTakeAction(this, std::get<TakeAction>(action.event)); break; } // If the reader wants to take some books, transfer this wish to the library
            case Action::Type::RETURN: { std::get<Library*>(action.executor)->EnqueueReturnAction(this, std::get<ReturnAction>(action.event)); break; } // If the reader wants to return a book, transfer this wish to the library
        
            case Action::Type::TAKEN:
            {
                TakenAction& event = std::get<TakenAction>(action.event); // Get the actual action
                this->EnqueueReturnAction(clock::now() - this->epoch + std::chrono::seconds(event.return_time), std::get<Library*>(action.executor), event.book); // Enqueue the action to return the book when needed
                break;
            }
            case Action::Type::WAIT:
            {
                WaitAction& event = std::get<WaitAction>(action.event); // Get the actual action
                this->waiting_books.insert_or_assign(event.book, event.return_time); // Add the book to the awaited list
                break;
            }
            case Action::Type::APPEAR:
            {
                AppearAction& event = std::get<AppearAction>(action.event); // Get the actual action
                if (!this->waiting_books.contains(event.book)) continue; // If the reader has not been waiting for the book, do not do anything (something went wrong)
                this->EnqueueTakeAction(std::chrono::seconds(0), std::get<Library*>(action.executor), { event.book, this->waiting_books.at(event.book) }); // Enqueue the action to take the book as soon as possible
                this->waiting_books.erase(event.book); // Remove the book from the awaited list
                break;
            }
        }
    }
}

Reader::Reader(size_t id) : id(id) { } // The constructor does not have to do anything: the Mutex'es will be constructed automatically
Reader::~Reader() { delete this->thread; } // If the reader is still running, it has to stop. If it is not running, this->thread is nullptr, and delete nullptr is a valid nop

void Reader::Start(threading::Barrier* sync_time_barrier, size_t work_time)
{
    /*
        Start a separate thread:
        1. The function to call on the thread is Reader::Run bound to this instance of Reader taking two parameters of types threading::Barrier* and size_t respectively
        2. std::bind constructs an std::function instance that allows to call the member function directly
        3. The values of the arguments are sync_time_barrier and work_time
    */
    this->thread = new thread_type(std::bind(&Reader::Run, this, std::placeholders::_1, std::placeholders::_2), sync_time_barrier, work_time); // save the pointer to the thread object in the member variable
}
void Reader::Stop()
{
    delete this->thread; // Join the thread and delete its descriptor
    this->thread = nullptr; // Clean the pointer
}



template <class ActionType> void Reader::EnqueueAction(std::chrono::nanoseconds time, Library* library, ActionType event)
{
    this->actions_access.Lock(); // lock the access to the queue
    this->actions.push(Action { time, library, event }); // put the action to the queue (constructing the Action object in-place) and sort it according to its priority/time
    this->actions_access.Unlock(); // unlock the access to the queue
}
// Just call the helper with the needed template specialization
void Reader::EnqueueTakeAction(std::chrono::nanoseconds time, Library* library, std::pair<Book, size_t> book1)
    { this->EnqueueAction<TakeAction>(time, library, TakeAction { book1 }); }
void Reader::EnqueueTakeAction(std::chrono::nanoseconds time, Library* library, std::pair<Book, size_t> book1, std::pair<Book, size_t> book2)
    { this->EnqueueAction<TakeAction>(time, library, TakeAction { book1, book2 }); }
void Reader::EnqueueTakeAction(std::chrono::nanoseconds time, Library* library, std::pair<Book, size_t> book1, std::pair<Book, size_t> book2, std::pair<Book, size_t> book3)
    { this->EnqueueAction<TakeAction>(time, library, TakeAction { book1, book2, book3 }); }
void Reader::EnqueueReturnAction(std::chrono::nanoseconds time, Library* library, Book book)
    { this->EnqueueAction<ReturnAction>(time, library, { book }); }

void Reader::EnqueueTakenAction(Library* library, Book book, size_t time)
    { this->EnqueueAction<TakenAction>(std::chrono::seconds(0), library, TakenAction { book, time }); }
void Reader::EnqueueWaitAction(Library* library, Book book, size_t time)
    { this->EnqueueAction<WaitAction>(std::chrono::seconds(0), library, WaitAction { book, time }); }
void Reader::EnqueueAppearAction(Library* library, Book book)
    { this->EnqueueAction<AppearAction>(std::chrono::seconds(0), library, { book }); }