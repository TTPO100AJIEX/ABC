#include "Library.h"

#include <iomanip>
#include <functional>
#include "../Reader/Reader.h"
#include "../Utilities/io/io.h"

void Library::Run(threading::Barrier* sync_time_barrier, size_t work_time)
{
    sync_time_barrier->Wait(); // Wait for all readers to start
    this->epoch = clock::now(); // Save the current time - the time when everything starts
    while (clock::now() - this->epoch <= std::chrono::seconds(work_time)) // while the library has not worked long enough, it should continue
    {
        this->actions_access.Lock(); // Lock the queue of actions to execute the first one
        if (this->actions.empty()) { this->actions_access.Unlock(); continue; } // If there are no actions to handle, unlock the access to the queue and proceed to the next iteration
        Action action = this->actions.front(); // Get the first action in the queue
        this->actions.pop(); // Remove the first action from the queue
        this->actions_access.Unlock(); // Unlock the access to the queue

        switch (action.GetType()) // Check the type of the event
        {
            case Action::Type::TAKE:
            {
                TakeAction& event = std::get<TakeAction>(action.event); // Get the actual action object
                switch (event.Amount()) // Check the amount of books requested
                {
                    case 3: { this->GiveBook(std::get<Reader*>(action.executor), event.book3.value().first, event.book3.value().second); [[fallthrough]]; } // If the request is for 3 books, give the third book to the Reader pointed by Action::executor
                    case 2: { this->GiveBook(std::get<Reader*>(action.executor), event.book2.value().first, event.book2.value().second); [[fallthrough]]; } // If the request is for 2 or more books, give the second book to the Reader pointed by Action::executor
                    case 1: { this->GiveBook(std::get<Reader*>(action.executor), event.book1.first, event.book1.second); } // If the request is for 1 or more books, give the first book to the Reader pointed by Action::executor
                }
                break;
            }
            case Action::Type::RETURN:
            {
                ReturnAction& event = std::get<ReturnAction>(action.event); // Get the actual action object
                this->ReturnBook(std::get<Reader*>(action.executor), event.book); // Handle the receiving of the book from the Reader pointed by Action::executor
                break;
            }
        
            case Action::Type::TAKEN: { break; } // The library does not handle this type of action
            case Action::Type::WAIT: { break; } // The library does not handle this type of action
            case Action::Type::APPEAR: { break; } // The library does not handle this type of action
        }
    }
}
void Library::Log(LogType type, std::chrono::duration< double, std::ratio<1> > time, const Reader& reader, const Book& book) const
{
    // Print the output in parts
    io::stream << io::Output::Precision{5} << std::fixed << time.count() << "s: reader " << reader.GetId() << " ";
    switch (type)
    {
        case LogType::TAKES: { io::stream << "takes"; break; }
        case LogType::REQUESTS: { io::stream << "requests"; break; }
        case LogType::RETURNS: { io::stream << "returns"; break; }
    }
    io::stream << " book " << book.id <<"\n";
}

Library::Library() { } // The constructor does not have to do anything: the Mutex'es will be constructed automatically
Library::~Library() { delete this->thread; } // If the library is still running, it has to stop. If it is not running, this->thread is nullptr, and delete nullptr is a valid nop

void Library::Start(threading::Barrier* sync_time_barrier, size_t work_time)
{
    /*
        Start a separate thread:
        1. The function to call on the thread is Library::Run bound to this instance of Library taking two parameters of types threading::Barrier* and size_t respectively
        2. std::bind constructs an std::function instance that allows to call the member function directly
        3. The values of the arguments are sync_time_barrier and work_time
    */
    this->thread = new thread_type(std::bind(&Library::Run, this, std::placeholders::_1, std::placeholders::_2), sync_time_barrier, work_time); // save the pointer to the thread object in the member variable
}
void Library::Stop()
{
    delete this->thread; // Join the thread and delete its descriptor
    this->thread = nullptr; // Clean the pointer
}



void Library::AddBook(Book book, size_t amount)
{
    if (amount <= 0) return; // The book cannot exist with a non-positive amount of copies
    if (books.contains(book)) { books.at(book) += amount; return; } // If the library already has some copies of this book, just increase the counter
    books.insert_or_assign(book, amount); // Insert a new book to the storage
}

void Library::GiveBook(Reader* reader, Book book, size_t return_time)
{
    if (!this->books.contains(book)) return; // If the book is unknown (no copies of this book have ever been seen), the library cannot give anything
    if (this->books.at(book) <= 0) // If the are no available copies of the book, put the reader into the waiting queue
    {
        waiting[book].insert(reader); // Insert the reader into the waiting queue under the ID of the requested book
        reader->EnqueueWaitAction(this, book, return_time); // Tell the reader to wait for the book
        this->Log(LogType::REQUESTS, clock::now() - this->epoch, *reader, book); // Log the action
        return;
    }
    this->books.at(book)--; // One copy is being transferred to the reader
    reader->EnqueueTakenAction(this, book, return_time); // Tell the reader that the book has been successfully retrieved
    this->Log(LogType::TAKES, clock::now() - this->epoch, *reader, book); // Log the action
}

void Library::ReturnBook(Reader* reader, Book book)
{
    if (!this->books.contains(book)) return; // If the book is unknown (no copies of this book have ever been seen), the book cannot be returned (an error has happened somewhere)
    this->books.at(book)++; // One copy is being returned: increase the counter
    for (Reader* reader : waiting[book]) reader->EnqueueAppearAction(this, book); // Tell everyone, who has been waiting for this book that it has appeared
    waiting[book].clear(); // Clear the list of the users who have been waiting for the book: they can come and take it now
    this->Log(LogType::RETURNS, clock::now() - this->epoch, *reader, book); // Log the action
}



template <class ActionType> void Library::EnqueueAction(Reader* reader, ActionType event)
{
    this->actions_access.Lock(); // lock the access to the queue
    this->actions.push(Action { std::chrono::seconds(0), reader, event }); // put the action to the end of the queue (constructing the Action object in-place)
    this->actions_access.Unlock(); // unlock the access to the queue
}
// Just call the helper with the needed template specialization
void Library::EnqueueTakeAction(Reader* reader, TakeAction event) { this->EnqueueAction<TakeAction>(reader, event); }
void Library::EnqueueReturnAction(Reader* reader, ReturnAction event) { this->EnqueueAction<ReturnAction>(reader, event); }