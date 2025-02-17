#include "error_check.h"
#include <iostream>

void GLAPIENTRY messageCallback(GLenum source,
    GLenum type,
    GLuint id,
    GLenum severity,
    GLsizei length,
    const GLchar* message,
    const void* userParam) 
{
    std::cout << message << std::endl;
}
