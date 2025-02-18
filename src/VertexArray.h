#pragma once
#include "VertexBuffer.h"
#include <vector>


struct AttributeElement
{
	unsigned int count;
	unsigned int size;
	unsigned int type;
};


class VertexArray
{
	unsigned int m_buffer;
public:
	VertexArray(VertexBuffer& vbo, std::vector<AttributeElement> attributes);
	~VertexArray();
	void Bind();
	void Unbind();
};

