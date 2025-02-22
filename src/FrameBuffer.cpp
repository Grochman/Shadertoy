#include "FrameBuffer.h"
#include <GL/glew.h>

FrameBuffer::FrameBuffer(unsigned int width, unsigned int height)
    : m_width(width), m_height(height)
{
    glGenFramebuffers(1, &m_buffer);
    glBindFramebuffer(GL_FRAMEBUFFER, m_buffer);

    glGenTextures(1, &m_frame_buffer_texture);
    glBindTexture(GL_TEXTURE_2D, m_frame_buffer_texture);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, m_width, m_height, 0, GL_RGBA, GL_UNSIGNED_BYTE, 0);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, m_frame_buffer_texture, 0);
}
FrameBuffer::~FrameBuffer()
{

}
void FrameBuffer::Bind()
{
    glBindFramebuffer(GL_FRAMEBUFFER, m_buffer);
}
void FrameBuffer::Undind()
{
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
}

void FrameBuffer::BindTexture() 
{
    glBindTexture(GL_TEXTURE_2D, m_frame_buffer_texture);
}
