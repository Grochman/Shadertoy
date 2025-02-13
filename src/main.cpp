#include <GL/glew.h>
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


    std::string vertexShader;
    ReadShader("res/shaders/plane_vert.shader", vertexShader);
    std::string fragmentShader;
    ReadShader("res/shaders/mandelbrot_set_frag.shader", fragmentShader);
    std::string fragmentShader2;
    ReadShader("res/shaders/stolen.shader", fragmentShader2);

    
    unsigned int shader = CreateShader(vertexShader, fragmentShader2);
    glUseProgram(shader);

    int timeLocation = glGetUniformLocation(shader, "u_time");
    int windowResolutionLocation = glGetUniformLocation(shader, "u_resolution");
    glUniform2f(windowResolutionLocation, float(WINDOW_WIDTH), float(WINDOW_HEIGHT));

    while (!glfwWindowShouldClose(window))
    {
        float timeValue = glfwGetTime();
        glUniform1f(timeLocation, timeValue);

        glClear(GL_COLOR_BUFFER_BIT);
        
        glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
        
        glfwSwapBuffers(window);

        glfwPollEvents();
    }

    glDeleteProgram(shader);
    
    glfwTerminate();
    return 0;
}