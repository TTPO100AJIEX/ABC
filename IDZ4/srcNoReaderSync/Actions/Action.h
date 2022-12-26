#pragma once

#include <chrono>
#include <variant>

class Library;
class Reader;
#include "./Take.h"
#include "./Return.h"
#include "./Taken.h"
#include "./Appear.h"
#include "./Wait.h"

struct Action
{
    std::chrono::nanoseconds time; // nanoseconds from Reader::epoch/Library::epoch when to execute the action
    std::variant <Library*, Reader*> executor; // Who is responsible for executing the action; The other one - initiator
    std::variant <TakeAction, ReturnAction, TakenAction, WaitAction, AppearAction> event; // The action to execute
    
    enum class Type { TAKE = 0, RETURN = 1, TAKEN = 2, WAIT = 3, APPEAR = 4 };
    Type GetType() const { return (Type)(this->event.index()); } // Checks, which type is set in the variant and returns the repective value of enum

    friend bool operator< (const Action& lhs, const Action& rhs) { return lhs.time > rhs.time; } // Actions priority: the action with smaller time has higher priority
};