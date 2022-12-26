#pragma once

#include <cstddef>
#include <unordered_map>
#include <queue>
#include <memory>
#include <utility>
#include <chrono>
#include "../Utilities/threading/threading.h"

#include "../Book/Book.h"
#include "../Actions/Action.h"
class Library; // forward-declare the library as only the pointer to it is needed

class Reader
{
    using thread_type = threading::Thread<threading::Barrier*, size_t>; // alias for the type of the thread for cleaner code
    using clock = std::conditional_t<std::chrono::high_resolution_clock::is_steady, std::chrono::high_resolution_clock, std::chrono::steady_clock>; // The clock type to use for timing
private:
    size_t id; // ID of the reader
    std::unordered_map<Book, size_t> waiting_books; // The list of books the user is waiting for (with the time it will take him to read and retrun the book back to the library)

    threading::Mutex actions_access; // Synchronization of access to the queue as it can be accessed by both the library and the readers
    std::priority_queue<Action> actions; // The priority queue of Actions this reader has to do: the actions with smaller time are handled first (look Action::operator<)
    
    thread_type* thread = nullptr; // Object that describes the thread where the library runs
	clock::time_point epoch; // Start time (synchronized with the library and other readers using a global barrier)
    void Run(threading::Barrier* sync_time_barrier, size_t work_time); // Runner: reads actions from the queue and plans how to handle them

public:
    // Function that are executed by the main thread
    explicit Reader(size_t id); // Constructor
    ~Reader(); // Destructor
    void Start(threading::Barrier* sync_time_barrier, size_t work_time); // Start the reader [ in a separate thread ]
    void Stop(); // Wait for the reader to complete all actions and stop

    // Function that are executed by other threads (and may need synchronization)
private:
    template <class ActionType> void EnqueueAction(std::chrono::nanoseconds time, Library* library, ActionType event); // Helper to enqueue the action of any type
public:
    void EnqueueTakeAction(std::chrono::nanoseconds time, Library* library, std::pair<Book, size_t> book1); // Enqueue the desire to take one book
    void EnqueueTakeAction(std::chrono::nanoseconds time, Library* library, std::pair<Book, size_t> book1, std::pair<Book, size_t> book2); // Enqueue the desire to take two books
    void EnqueueTakeAction(std::chrono::nanoseconds time, Library* library, std::pair<Book, size_t> book1, std::pair<Book, size_t> book2, std::pair<Book, size_t> book3); // Enqueue the desire to take three books
    void EnqueueReturnAction(std::chrono::nanoseconds time, Library* library, Book book); // Enqueue the desire to return a book

    void EnqueueTakenAction(Library* library, Book book, size_t time); // Handle the message from the library that the book has been successfully taken
    void EnqueueWaitAction(Library* library, Book book, size_t time); // Handle the message from the library that the book is not currently present
    void EnqueueAppearAction(Library* library, Book book); // Handle the message from the library that a desired book has appeared in the library

    size_t GetId() const { return this->id; } // Getter for the ID of this reader
};


struct ReaderUniquePtrHash // Create an overload of hash function of std::unique_ptr<Reader> for use in unordered_set
{
    std::size_t operator()(const std::unique_ptr<Reader>& reader) const { return std::hash<std::size_t>()(reader->GetId()); }
};
struct ReaderUniquePtrEqual // Create an overload of equality of std::unique_ptr<Reader> for use in unordered_set
{
    bool operator()(const std::unique_ptr<Reader>& left, const std::unique_ptr<Reader>& right) const  { return left->GetId() == right->GetId(); }
};