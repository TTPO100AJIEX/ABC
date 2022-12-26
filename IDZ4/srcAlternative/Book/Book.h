#pragma once

#include <cstddef>
#include <compare>
#include <functional>

struct Book
{
    size_t id; // ID of the book

    auto operator<=>(const Book& other) const = default; // overload all comparison operators
};

template<> struct std::hash<Book> // overload std::hash for Book to let it work as a key in unordered_map
{
    std::size_t operator()(const Book& book) const { return std::hash<std::size_t>()(book.id); }
};