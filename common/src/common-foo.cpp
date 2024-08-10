#include <common-foo.hpp>

#include <iostream>

#ifndef COMMON_TEST_DEFINE_2
#define COMMON_TEST_DEFINE_2 50
#endif // COMMON_TEST_DEFINE2

void hello()
{
    std::cout << "COMMON_TEST_DEFINE1: " << COMMON_TEST_DEFINE_1 << std::endl;
    std::cout << "COMMON_TEST_DEFINE2: " << COMMON_TEST_DEFINE_2 << std::endl;
}
