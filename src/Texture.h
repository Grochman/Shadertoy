#pragma once
#include <string>

class Texture
{
	std::string m_path;
	unsigned int m_buffer;
	const char* m_texture_data;
	int m_width, m_height, m_bpp;
public:
	Texture(std::string path);
	~Texture();
	void Bind(unsigned int idx = 0);
	void Unbind();
};

