#include "./threading.h"

namespace threading
{
    Barrier::Barrier(unsigned int amount)
    {
        pthread_barrier_init(&(this->descriptor), nullptr, amount); // Initialize the barrier
    }
    Barrier::~Barrier()
    {
        pthread_barrier_destroy(&(this->descriptor)); // Destroy the barrier
    }
    void Barrier::Wait()
    {
        pthread_barrier_wait(&(this->descriptor)); // Wait on the barrier
    }


    Mutex::Mutex()
    {
        pthread_mutex_init(&(this->descriptor), nullptr); // Initialize the mutex
    }
    Mutex::~Mutex()
    {
        pthread_mutex_destroy(&(this->descriptor)); // Destroy the mutex
    }
    void Mutex::Lock()
    {
        pthread_mutex_lock(&(this->descriptor)); // Lock the mutex
    }
    void Mutex::Unlock()
    {
        pthread_mutex_unlock(&(this->descriptor)); // Unlock the mutex
        pthread_yield(); // Make the current thread leave the CPU to let other threads take control of the mutex
    }
}