#pragma once

#include <cstddef>
#include <unordered_map>
#include <unordered_set>
#include <queue>
#include <chrono>
#include "../Utilities/threading/threading.h"

#include "../Book/Book.h"
#include "../Actions/Action.h"
class Reader; // forward-declare the reader as only the pointer to it is needed

class Library
{
    using thread_type = threading::Thread<threading::Barrier*, size_t>; // alias for the type of the thread for cleaner code
    using clock = std::conditional_t<std::chrono::high_resolution_clock::is_steady, std::chrono::high_resolution_clock, std::chrono::steady_clock>; // The clock type to use for timing
private:
    std::unordered_map <Book, size_t> books; // The storage for books: Book -> amount
    std::unordered_map <Book, std::unordered_set<Reader*> > waiting; // The list of Readers who are waiting for each Book: Book -> ListOfReaders

    threading::Mutex actions_access; // Synchronization of access to the queue as it can be accessed by both the library and the readers
    std::queue<Action> actions; // The queue of Readers who want to do something in the library

    thread_type* thread = nullptr; // Object that describes the thread where the library runs
	clock::time_point epoch; // Start time (synchronized with the readers using a global barrier)
    void Run(threading::Barrier* sync_time_barrier, size_t work_time); // Runner: reads actions from the queue and plans how to handle them

    enum class LogType { TAKES, REQUESTS, RETURNS };
    void Log(LogType type, std::chrono::duration<double, std::ratio<1> > time, const Reader& reader, const Book& book) const;

public:
    // Function that are executed by the main thread
    Library(); // Constructor
    ~Library(); // Destructor
    void Start(threading::Barrier* sync_time_barrier, size_t work_time); // Start the library [ in a separate thread ]
    void Stop(); // Wait for the library to complete all actions and stop

    void AddBook(Book book, size_t amount); // Add a new book to the storage
    void GiveBook(Reader* reader, Book book, size_t time); // Give the specified book to the specified reader
    void ReturnBook(Reader* reader, Book book); // Handle the reader returning the book

    // Function that are executed by other threads (and may need synchronization)
private:
    template <class ActionType> void EnqueueAction(Reader* reader, ActionType event); // Helper to enqueue the action of any type
public:
    void EnqueueTakeAction(Reader* reader, TakeAction book); // Enqueue the desire to take a book
    void EnqueueReturnAction(Reader* reader, ReturnAction book); // Enqueue the desire to return a book

};