#include <GL/glew.h>
#include "Renderer.h"
#include <fstream>
#include <iostream>

void Renderer::updateMousePos()
{
    double mousexpos, mouseypos;
    glfwGetCursorPos(m_window, &mousexpos, &mouseypos);
    m_shader.SetUniform2f("u_mouse", mousexpos, mouseypos);
}

void Renderer::updateTime()
{
    float timeValue = glfwGetTime();
    m_shader.SetUniform1f("u_time", timeValue);
}


Renderer::Renderer(GLFWwindow* window,Shader& shader): m_window(window), m_shader(shader)
{
    glfwGetWindowSize(m_window, &m_window_w, &m_window_h);
}

void Renderer::run() 
{    
    m_shader.Bound();

    m_shader.SetUniform2f("u_resolution", float(m_window_w), float(m_window_h));
    
    while (!glfwWindowShouldClose(m_window))
    {
        updateTime();
        updateMousePos();

        glClear(GL_COLOR_BUFFER_BIT);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, nullptr);
        glfwSwapBuffers(m_window);
        glfwPollEvents();
    }
}

Renderer::~Renderer()
{

}
