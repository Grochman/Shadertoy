#pragma once
class FrameBuffer
{
    unsigned int m_buffer;
    unsigned int m_frame_buffer_texture;
    unsigned int m_width;
    unsigned int m_height;
public:
    FrameBuffer(unsigned int width, unsigned int height);
    ~FrameBuffer();
    void Bind();
    void Undind();
    void BindTexture();
};

