#include "./threading.h"

#include <iostream>

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
        sem_init(&(this->descriptor), 0, 1); // Initialize the semaphore
    }
    Mutex::~Mutex()
    {
        sem_destroy(&(this->descriptor)); // Destroy the semaphore
    }
    void Mutex::Lock()
    {
        sem_wait(&(this->descriptor)); // Lock the semaphore
    }
    void Mutex::Unlock()
    {
        sem_post(&(this->descriptor)); // Unlock the semaphore
        pthread_yield(); // Make the current thread leave the CPU to let other threads take control of the resource
    }
}