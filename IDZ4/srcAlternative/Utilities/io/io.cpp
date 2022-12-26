#include "io.h"

#include <iostream>
#include <fstream>
#include <cstdio>
#include <exception>
#include <string>
#include <random>
#include <vector>

io::IoWrapper io::stream;
void io::Init(int argc, char** argv)
{
    // The programm should always output to the console and to the file.
    io::stream.output_.push_back(std::make_unique<ConsoleOutput>()); // Initialize the output to the console
    io::stream.output_.push_back(std::make_unique<FileOutput>("result.out")); // Initialize the output to the file

    if (argc < 2) throw std::runtime_error("Incorrect amount of command line arguments"); // If not enough arguments have been passed, throw an exception

    if (std::string(argv[1]) == "-c") { io::stream.input_ = std::make_unique<CLIInput>(argv); return; } // Input from command line arguments
    if (std::string(argv[1]) == "-s") { io::stream.input_ = std::make_unique<ConsoleInput>(); return; } // Input from the console
    if (std::string(argv[1]) == "-f")
    {
        if (argc < 3) throw std::runtime_error("Incorrect amount of command line arguments"); // If not enough arguments have been passed, throw an exception
        io::stream.input_ = std::make_unique<FileInput>(argv[2]); // Input from the file at argv[2]
        return;
    }
    io::stream.input_ = std::make_unique<RandomInput>(); // Generate random inputs
}



// Overload of input operator just forwards the argument to the input operator of std::cin
io::ConsoleInput& io::ConsoleInput::operator>>(size_t& obj) { std::cin >> obj; return *this; }

io::FileInput::FileInput(const std::string& filename) { this->filestream.open(filename); } // Constructor: opens the file
io::FileInput::~FileInput() { this->filestream.close(); } // Destructor: closes the file
// Overload of input operator just forwards the argument to the input operator of the filestream
io::FileInput& io::FileInput::operator>>(size_t& obj) { this->filestream >> obj; return *this; }

io::CLIInput::CLIInput(char** argv) { this->next_data = &argv[2]; } // Constructor: saved the pointer to the beginning of the data
// Overload of input operator just forwards the argument to the input operator of the filestream
io::CLIInput& io::CLIInput::operator>>(size_t& obj) { obj = std::stoull(this->next_data[0]); this->next_data = &this->next_data[1]; return *this; }

io::RandomInput::RandomInput() // Constructor: generated the data
{
    std::random_device dev; // Seed generator for the random
    std::mt19937 gen(dev()); // The actual generator
    std::uniform_int_distribution<std::mt19937::result_type> random_10(1, 10), random_100(1, 100), random_600(1, 600), random_1e5(1, 1e5), random_1e9(1, 1e9); // Uniform distributions to generate the numbers for the input
    
    size_t amount_of_books = random_1e5(gen); this->data.push_back(amount_of_books); // Generate the amount of books
    this->data.push_back(random_600(gen)); // Generate the work time (up to 10 minutes)
    std::vector<size_t> book_ids; // The storage of book ids for further use
    for (size_t i = 0; i < amount_of_books; i++)
    {
        book_ids.push_back(random_1e9(gen)); this->data.push_back(book_ids[book_ids.size() - 1]); // Generate the id of the book
        this->data.push_back(random_1e5(gen)); // Generate the amount of copies of the book available
    }
    
    size_t amount_of_readers = random_1e5(gen); this->data.push_back(amount_of_readers); // Generate the amount of readers
    std::vector<size_t> reader_ids; // The storage of reader ids for further use
    for (size_t i = 0; i < amount_of_readers; i++)
    {
        reader_ids.push_back(random_1e9(gen)); this->data.push_back(reader_ids[reader_ids.size() - 1]); // Generate the id of the reader
    }

    std::uniform_int_distribution<std::mt19937::result_type> random_3(1, 3), random_book(1, book_ids.size() - 1), random_reader(1, reader_ids.size() - 1); // Uniform distributions to generate a random BookID and ReaderID
    
    size_t amount_of_events = random_1e5(gen); this->data.push_back(amount_of_events); // Generate the amount of events
    for (size_t i = 0; i < amount_of_events; i++)
    {
        this->data.push_back(random_100(gen)); // Generate the time of the event (up to 100 to allow for resolving conflicts in reasonable time)
        this->data.push_back(reader_ids[random_reader(gen)]); // Generate the reader to perform the action
        size_t amount_to_take = random_3(gen); this->data.push_back(amount_to_take); // Generate the amount of books the reader should request
        for (size_t j = 0; j < amount_to_take; j++)
        {
            this->data.push_back(book_ids[random_book(gen)]); // Generate the book to perform the action
            this->data.push_back(random_10(gen)); // Generate for how long to take the book (up to 10 seconds for the program to work reasonable time and resolve most/all of the actions scheduled)
        }
    }
}
io::RandomInput& io::RandomInput::operator>>(size_t& obj)
{
    obj = this->data.front(); // Read the next element
    this->data.pop_front(); // Remove the read element from the storage
    return *this;
}


// Overloads of the operator just forward the argument to the output operator of std::cout
io::ConsoleOutput& io::ConsoleOutput::operator<<(const double& obj)               { std::cout << obj; return *this; }
io::ConsoleOutput& io::ConsoleOutput::operator<<(const size_t& obj)               { std::cout << obj; return *this; }
io::ConsoleOutput& io::ConsoleOutput::operator<<(const std::string& obj)          { std::cout << obj; return *this; }
io::ConsoleOutput& io::ConsoleOutput::operator<<(const Precision& obj)            { std::cout << std::setprecision(obj.digits); return *this; }
io::ConsoleOutput& io::ConsoleOutput::operator<<(decltype(std::fixed)& obj) { std::cout << obj; return *this; }

io::FileOutput::FileOutput(const std::string& filename) { this->filestream.open(filename); } // Constructor: opens the file
io::FileOutput::~FileOutput() { this->filestream.close(); } // Destructor: closes the file
// Overloads of the operator just forward the argument to the output operator of the filestream
io::FileOutput& io::FileOutput::operator<<(const double& obj)               { this->filestream << obj; return *this; }
io::FileOutput& io::FileOutput::operator<<(const size_t& obj)               { this->filestream << obj; return *this; }
io::FileOutput& io::FileOutput::operator<<(const std::string& obj)          { this->filestream << obj; return *this; }
io::FileOutput& io::FileOutput::operator<<(const Precision& obj)            { this->filestream << std::setprecision(obj.digits); return *this; }
io::FileOutput& io::FileOutput::operator<<(decltype(std::fixed)& obj) { this->filestream << obj; return *this; }



// Overload of input operator just forwards the argument to the input operator of the input stream
io::IoWrapper& io::IoWrapper::operator>>(size_t& obj) { (*this->input_) >> obj; return *this; }

// Overloads of output operator just forward the argument to the output operator of all registered output streams
io::IoWrapper& io::IoWrapper::operator<<(const double& obj)               { for (const std::unique_ptr<Output>& output : this->output_) (*output) << obj; return *this; }
io::IoWrapper& io::IoWrapper::operator<<(const size_t& obj)               { for (const std::unique_ptr<Output>& output : this->output_) (*output) << obj; return *this; }
io::IoWrapper& io::IoWrapper::operator<<(const std::string& obj)          { for (const std::unique_ptr<Output>& output : this->output_) (*output) << obj; return *this; }
io::IoWrapper& io::IoWrapper::operator<<(const Output::Precision& obj)    { for (const std::unique_ptr<Output>& output : this->output_) (*output) << obj; return *this; }
io::IoWrapper& io::IoWrapper::operator<<(decltype(std::fixed)& obj) { for (const std::unique_ptr<Output>& output : this->output_) (*output) << obj; return *this; }