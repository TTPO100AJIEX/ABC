#pragma once

#include <tuple>
#include <functional>
#include <pthread.h>

namespace threading
{
    class Barrier // Wrapper around pthread_barrier
    {
    private:
        pthread_barrier_t descriptor; // The descriptor of the barrier
    public:
        Barrier(unsigned int amount); // Constructor
        ~Barrier(); // Destructor
        void Wait(); // Wait on this barrier
    };

    class Mutex // Wrapper around pthread_mutex
    {
    private:
        pthread_mutex_t descriptor; // The descriptor of the mutex
    public:
        Mutex(); // Constructor
        ~Mutex(); // Destructor
        void Lock(); // Lock the mutex
        void Unlock(); // Unlock the mutex
    };

    template < typename... Parameters > // Parameters that are transmitted to the thread (can be any number - variadic template)
    class Thread // Wrapper aroung a separate pthread thread that does not return anything
    {
        using worker_function = std::function<void(Parameters...)>; // just alias for cleaner code
        using transfer_tuple = std::tuple<worker_function, Parameters...>; // just alias for cleaner code
        // As the class is templated, the implementations cannot be moved to a separate source file
    private:
        pthread_t descriptor; // The descriptor of the thread

        static void* Run(void* args) // Helper to run the thread
        {
            const transfer_tuple& data = *((transfer_tuple*)(args)); // Cast the received argument to the tuple of worker + args
            std::apply(
                std::get<worker_function>(data), // get the worker from the tuple
                std::tuple<Parameters...>(std::get<Parameters>(data)...) // construct a new tuple with all data from the received tuple except worker
            ); // call the worker with args applied as a tuple
            delete (transfer_tuple*)(args); // Free the memory occupied by the transmitted tuple to avoid a memory leak
            return nullptr; // Do not return anything
        }

    public:
        Thread(worker_function worker, const Parameters&... args) // Constructor
        {
            pthread_create(&(this->descriptor), nullptr, Thread::Run, new transfer_tuple(worker, args...)); // Run Thread::Run in a new thread with a pointer to a tuple of worker + args as arguments
        }
        ~Thread() // Destructor
        {
            pthread_join(this->descriptor, nullptr); // Wait for the thread to finish the job
        }
    };
}