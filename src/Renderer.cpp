#include <GL/glew.h>
#include "Renderer.h"
#include <fstream>
#include <iostream>


Renderer::Renderer(Shader& shader, VertexArray& vao, IndexBuffer& ibo)
    : m_shader(shader), m_vao(vao), m_ibo(ibo)
{
}

Renderer::~Renderer()
{
}

void Renderer::draw() 
{    
    m_shader.Bind();
    m_ibo.Bind();
    m_vao.Bind();
    glDrawElements(GL_TRIANGLES, m_ibo.getCount(), GL_UNSIGNED_INT, nullptr);
}
