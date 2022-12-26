#pragma once

#include "../Book/Book.h"

struct TakenAction
{
    Book book; // Book that has been taken
    size_t return_time; // For how long the reader can have the book
};