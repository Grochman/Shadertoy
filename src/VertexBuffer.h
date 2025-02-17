#pragma once

class VertexBuffer
{
    unsigned int m_buffer;
    unsigned int m_size;

public:
    VertexBuffer(const void* data, unsigned int size);
    ~VertexBuffer();
    void Bind();
    void Unbind();
};

