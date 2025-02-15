#pragma once
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

unsigned int CreateShader(const std::string& vertexShader, const std::string& fragmentShader);

std::string ReadShader(const char* path);