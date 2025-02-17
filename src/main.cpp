#include <GL/glew.h>gir
#include <GLFW/glfw3.h>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

#include "functions.h"

#define WINDOW_HEIGHT 600
#define WINDOW_WIDTH 600


int main(void)
{
    GLFWwindow* window;

    if (!glfwInit())
        return -1;

    window = glfwCreateWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Hello World", NULL, NULL);
    if (!window)
    {
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);

    if (glewInit()!=GLEW_OK)
        return -1;
    std::cout << glGetString(GL_VERSION) << std::endl;
    
    glEnable(GL_DEBUG_OUTPUT);
    glDebugMessageCallback(messageCallback, 0);

    float possitions[] = {
        -1.0f, -1.0f,
         1.0f, -1.0f,
         1.0f,  1.0f,
        -1.0f,  1.0f
    };
    unsigned int indices[] = {
        0, 1, 2,
        2, 3, 0
    };
   
    unsigned int buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(possitions), possitions, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 2, 0);

    unsigned int ibo;
    glGenBuffers(1, &ibo);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ibo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);


    std::string square = ReadShader("res/shaders/vertex/simple.shader");
    
    std::string mandelbrot = ReadShader("res/shaders/fragment/mandelbrot_set.shader");
    std::string julia = ReadShader("res/shaders/fragment/julia_set.shader");
    std::string sphere = ReadShader("res/shaders/fragment/sphere.shader");
    std::string loading = ReadShader("res/shaders/fragment/loading.shader");
    
    std::string dots = ReadShader("res/shaders/fragment/dots.shader");
    std::string cross = ReadShader("res/shaders/fragment/cross.shader");
    std::string wobly = ReadShader("res/shaders/fragment/wobly_tiles.shader");
    
    std::string playground = ReadShader("res/shaders/fragment/playground.shader");


    run(window, square, dots);
    

    glfwTerminate();
    return 0;
}