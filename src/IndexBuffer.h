#pragma once
class IndexBuffer
{
    unsigned int m_buffer;
    unsigned int m_count;

public:
    IndexBuffer(const void* data, unsigned int size);
    void Bind();
    void Unbind();
    unsigned int getCount();
    ~IndexBuffer();
};

