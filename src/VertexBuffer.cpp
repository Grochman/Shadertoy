#include "VertexBuffer.h"
#include <GL/glew.h>

VertexBuffer::VertexBuffer(const void* data, unsigned int size): m_size(size)
{
    glGenBuffers(1, &m_buffer); // create buffer
    Bind();
    glBufferData(GL_ARRAY_BUFFER, size, data, GL_STATIC_DRAW); //load data to vram
}

VertexBuffer::~VertexBuffer()
{
    glDeleteBuffers(1, &m_buffer);
}

void VertexBuffer::Bind()
{
    glBindBuffer(GL_ARRAY_BUFFER, m_buffer); // buffer usage type
}

void VertexBuffer::Unbind()
{
    glBindBuffer(GL_ARRAY_BUFFER, 0);
}