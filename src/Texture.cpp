#include "Texture.h"
#include <GL/glew.h>
#include "vendor/stb_imgage/stb_image.h"

Texture::Texture(std::string path)
	:m_path(path), m_texture_data(nullptr), m_width(0), m_height(0), m_bpp(0)
{
	stbi_set_flip_vertically_on_load(1);
	m_texture_data = (char*)stbi_load(m_path.c_str(), &m_width, &m_height, &m_bpp, 4);

	glGenBuffers(1, &m_buffer);
	glBindTexture(GL_TEXTURE_2D, m_buffer);

	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, m_width, m_height, 0, GL_RGBA, GL_UNSIGNED_BYTE, m_texture_data);
}

Texture::~Texture()
{
	if (m_texture_data)
		stbi_image_free((void*)m_texture_data);
	
	glDeleteTextures(1, &m_buffer);
}
void Texture::Bind(unsigned int idx)
{
	glActiveTexture(GL_TEXTURE0 + idx);
	glBindTexture(GL_TEXTURE_2D, m_buffer);
}
void Texture::Unbind()
{
	glBindTexture(GL_TEXTURE_2D, 0);
}