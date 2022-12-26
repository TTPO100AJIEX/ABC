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
    }
    Mutex::~Mutex()
    {
    }
    void Mutex::Lock()
    {
    }
    void Mutex::Unlock()
    {
    }
}