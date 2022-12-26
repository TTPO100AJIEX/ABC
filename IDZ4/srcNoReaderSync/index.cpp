#include <cstddef>
#include <memory>
#include <unordered_set>
#include "Utilities/threading/threading.h"
#include "Utilities/io/io.h"

#include "./Library/Library.h"
#include "./Reader/Reader.h"

int main(int argc, char** argv)
{
    io::Init(argc, argv); // Initialize the io namespace - input and output streams
    
    // Initialize library and create books
    Library library; // The library instance
    size_t books_amount, work_time; io::stream >> books_amount >> work_time; // Input the amount of books available in the library and its working time
    for (size_t i = 0; i < books_amount; i++)
    {
        size_t id, amount; io::stream >> id >> amount; // Input the data of the i-th book
        library.AddBook({ id }, amount); // Add the new book to the libraryx
    }

    // Initialize readers
    std::unordered_set< std::unique_ptr<Reader>, ReaderUniquePtrHash, ReaderUniquePtrEqual > readers; // The storage of readers ndexed by id (look the overload of std::hash< std::unique_ptr<Reader> >)
    size_t readers_amount; io::stream >> readers_amount; // Input the amount of readers to be used in the programm
    for (size_t i = 0; i < readers_amount; i++)
    {
        size_t id; io::stream >> id; // Input the ID of the i-th reader
        readers.insert(std::make_unique<Reader>(id)); // Save the reader
    }
    
    // Initialize events
    size_t events_amount; io::stream >> events_amount; // Input the amoubt of take events
    for (size_t i = 0; i < events_amount; i++)
    {
        size_t time, reader_id, books_amount; io::stream >> time >> reader_id >> books_amount; // Input the time of the event, the ID of the reader, and the amount of books to get
        if (books_amount < 1 || books_amount > 3) { io::stream << "Reader " << reader_id << " asked for too many books (" << books_amount << ")"; return 1; } // The request is not valid if the amount of books requested is not between 1 and 3
        
        size_t books[3], return_times[3]; // Storage for descriptions of the books to take
        io::stream >> books[0] >> return_times[0]; // Input the information about the first request
        if (books_amount >= 2) io::stream >> books[1] >> return_times[1]; // Input the information about the second request if it exists
        if (books_amount >= 3) io::stream >> books[2] >> return_times[2]; // Input the information about the third request if it exists

        // Tell the reader to request some books at the specified time
        if (books_amount == 1) readers.find(std::make_unique<Reader>(reader_id))->get()->EnqueueTakeAction(std::chrono::seconds(time), &library, { { books[0] }, return_times[0] });
        if (books_amount == 2) readers.find(std::make_unique<Reader>(reader_id))->get()->EnqueueTakeAction(std::chrono::seconds(time), &library, { { books[0] }, return_times[0] }, { { books[1] }, return_times[1] });
        if (books_amount == 3) readers.find(std::make_unique<Reader>(reader_id))->get()->EnqueueTakeAction(std::chrono::seconds(time), &library, { { books[0] }, return_times[0] }, { { books[1] }, return_times[1] }, { { books[2] }, return_times[2] });
    }

    threading::Barrier barrier(readers.size() + 1); // Barrier for time synchronization
    library.Start(&barrier, work_time); // Start the library
    for (const std::unique_ptr<Reader>& reader : readers) reader->Start(&barrier, work_time); // Start the readers

    for (const std::unique_ptr<Reader>& reader : readers) reader->Stop(); // Wait for the readers to do the job and stop them
    library.Stop(); // Stop the library when it has done all the job
}