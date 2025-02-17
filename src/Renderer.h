#pragma once
#include "Shader.h"
#include "IndexBuffer.h"

class Renderer
{
	Shader& m_shader;
	unsigned int m_vao;
	IndexBuffer m_ibo;

public:
	Renderer(Shader& shader, unsigned int vao, IndexBuffer& ibo);
	void draw();
	~Renderer();
};

