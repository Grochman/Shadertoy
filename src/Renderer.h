#pragma once
#include "Shader.h"
#include "IndexBuffer.h"
#include "VertexArray.h"

class Renderer
{
	Shader& m_shader;
	VertexArray& m_vao;
	IndexBuffer& m_ibo;

public:
	Renderer(Shader& shader, VertexArray& vao, IndexBuffer& ibo);
	~Renderer();
	void draw();
};

