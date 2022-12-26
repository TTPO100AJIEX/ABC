#pragma once

#include <vector>
#include <memory>
#include <fstream>
#include <list>
#include <cstddef>
#include <iomanip>
#include <string>

class io
{
public:
    class Input // Base class for all input types
    {
    public:
        virtual Input& operator>>(size_t& obj) = 0; // Input operator interface
        virtual ~Input() = default; // virtual destructor to correctly destroy objects
    };
    
    class ConsoleInput : public Input
    {
    public:
        virtual ConsoleInput& operator>>(size_t& obj) override; // Input operator override
    };

    class FileInput : public Input
    {
        std::ifstream filestream; // Stream to read from

    public:
        virtual FileInput& operator>>(size_t& obj) override; // Input operator override
        FileInput(const std::string& filename); // Constructor
        ~FileInput(); // Destructor
    };

    class CLIInput : public Input
    {
        char** next_data;

    public:
        virtual CLIInput& operator>>(size_t& obj) override; // Input operator override
        CLIInput(char** argv); // Constructor (assumes that the input is specified correctly)
    };

    class RandomInput : public Input
    {
        std::list<size_t> data; // Storage for the generated data to be returned on request

    public:
        virtual RandomInput& operator>>(size_t& obj) override; // Input operator override
        RandomInput(); // Constructor (generated the data)
    };



    class Output
    {
    public:
        struct Precision // Type of std::setprecision is implementation-defined. So own Precision indicator has been create to avoid UB
        {
            unsigned short int digits; // The amount of digits to print
        };

        // Output operator interfaces
        virtual Output& operator<<(const double& obj) = 0;
        virtual Output& operator<<(const size_t& obj) = 0;
        virtual Output& operator<<(const std::string& obj) = 0;
        virtual Output& operator<<(const Precision& obj) = 0;
        virtual Output& operator<<(decltype(std::fixed)& obj) = 0;
        virtual ~Output() = default; // virtual destructor to correctly destroy objects
    };

    class ConsoleOutput : public Output
    {
    public:
        // Output operator overrides
        virtual ConsoleOutput& operator<<(const double& obj) override;
        virtual ConsoleOutput& operator<<(const size_t& obj) override;
        virtual ConsoleOutput& operator<<(const std::string& obj) override;
        virtual ConsoleOutput& operator<<(const Precision& obj) override;
        virtual ConsoleOutput& operator<<(decltype(std::fixed)& obj) override;
    };

    class FileOutput : public Output
    {
        std::ofstream filestream; // Stream to write to
    public:
        // Output operator overrides
        virtual FileOutput& operator<<(const double& obj) override;
        virtual FileOutput& operator<<(const size_t& obj) override;
        virtual FileOutput& operator<<(const std::string& obj) override;
        virtual FileOutput& operator<<(const Precision& obj) override;
        virtual FileOutput& operator<<(decltype(std::fixed)& obj) override;
        FileOutput(const std::string& filename); // Constructor
        ~FileOutput(); // Destructor
    };




    class IoWrapper
    {
        friend class io; // Friend to use this class
    private:
        std::unique_ptr<Input> input_; // One input stream
        std::vector< std::unique_ptr<Output> > output_; // Multiple output streams

    public:
        // Overload of input operator
        IoWrapper& operator>>(size_t& obj);

        // Overloads of output operator
        IoWrapper& operator<<(const double& obj);
        IoWrapper& operator<<(const size_t& obj);
        IoWrapper& operator<<(const std::string& obj);
        IoWrapper& operator<<(const Output::Precision& obj);
        IoWrapper& operator<<(decltype(std::fixed)& obj);
    };


public:
    static IoWrapper stream; // Public API to use read/write data
    static void Init(int argc, char** argv); // Public API to initialize the stream based on command line arguments

};