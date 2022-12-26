#pragma once

#include <cstddef>
#include <utility>
#include <optional>

#include "../Book/Book.h"

struct TakeAction
{
    // Up to three books that the reader wants to take. One is mandatory.
    std::pair<Book, size_t> book1;
    std::optional<std::pair<Book, size_t>> book2;
    std::optional<std::pair<Book, size_t>> book3;
    
    short int Amount() const
    {
        return(1 + (book2.has_value() ? 1 : 0) + (book3.has_value() ? 1 : 0)); // Amount of books to take: one mandatory, other if specified
    }

};