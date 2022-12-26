#pragma once

#include <cstddef>
#include "../Book/Book.h"

struct WaitAction
{
    Book book; // Book to wait
    size_t return_time; // For how long the reader can have the book after it appears
};