#include <iostream>

#include "hi.h"
#include <hello.h>

void libB::hi() {
    libA::hello();
    std::cout << "Hi World!" << std::endl;
}
