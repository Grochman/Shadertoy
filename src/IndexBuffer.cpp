#include "IndexBuffer.h"
#include <GL/glew.h>

IndexBuffer::IndexBuffer(const void* data, unsigned int count) : m_count(count) 
{
    glGenBuffers(1, &m_buffer);
    Bind();
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(unsigned int) * m_count, data, GL_STATIC_DRAW);
}

IndexBuffer::~IndexBuffer() 
{
    glDeleteBuffers(1, &m_buffer);
}

void IndexBuffer::Bind() 
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m_buffer);
}

void IndexBuffer::Unbind() 
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

unsigned int IndexBuffer::getCount() 
{
    return m_count;
}