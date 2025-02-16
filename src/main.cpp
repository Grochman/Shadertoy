#include <GL/glew.h>gir
#include <GLFW/glfw3.h>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include "functions.h"

#define WINDOW_HEIGHT 600
#define WINDOW_WIDTH 600


void run(GLFWwindow* window, const std::string& vertexShader, const std::string& fragmentShader) {
    unsigned int shader = CreateShader(vertexShader, fragmentShader);
    glUseProgram(shader);    
    
    int timeLocation = glGetUniformLocation(shader, "u_time");
    int resolutionLocation = glGetUniformLocation(shader, "u_resolution");
    glUniform2f(resolutionLocation, float(WINDOW_WIDTH), float(WINDOW_HEIGHT));
    int mouseLocation = glGetUniformLocation(shader, "u_mouse");

    double mousexpos, mouseypos;
    
    while (!glfwWindowShouldClose(window))
    {
        float timeValue = glfwGetTime();
        glUniform1f(timeLocation, timeValue);
    
        glfwGetCursorPos(window, &mousexpos, &mouseypos);
        glUniform2f(mouseLocation, float(mousexpos), float(mouseypos));

        glClear(GL_COLOR_BUFFER_BIT);

        glDrawArrays(GL_TRIANGLE_FAN, 0, 4);

        glfwSwapBuffers(window);

        glfwPollEvents();
    }

    glDeleteProgram(shader);
}

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
    std::cout << glGetString(GL_VERSION);
    

   float possitions[8] = {
        -1.0f, -1.0f,
        -1.0f,  1.0f,
         1.0f,  1.0f,
         1.0f, -1.0f
    };
    unsigned int buffer;
    glCreateBuffers(1, &buffer); //create buf
    glBindBuffer(GL_ARRAY_BUFFER, buffer); //bind
    glBufferData(GL_ARRAY_BUFFER, sizeof(possitions), possitions, GL_STATIC_DRAW); //load data
    glVertexAttribPointer(0,2,GL_FLOAT, GL_FALSE, sizeof(float) * 2, 0); //data layout
    glEnableVertexAttribArray(0); //idk


    std::string square = ReadShader("res/shaders/vertex/simple.shader");
    std::string mandelbrot = ReadShader("res/shaders/fragment/mandelbrot_set.shader");
    std::string julia = ReadShader("res/shaders/fragment/julia_set.shader");
    std::string playground = ReadShader("res/shaders/fragment/playground.shader");
    std::string black_white_hole = ReadShader("res/shaders/fragment/black_white_hole.shader");
    std::string heart = ReadShader("res/shaders/fragment/heart_beat.shader");
    std::string sphere = ReadShader("res/shaders/fragment/sphere.shader");
    std::string loading = ReadShader("res/shaders/fragment/loading.shader");

    run(window, square, julia);
    

    glfwTerminate();
    return 0;
}