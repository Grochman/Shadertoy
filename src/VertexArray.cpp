#include "VertexArray.h"
#include <GL/glew.h>

VertexArray::VertexArray(VertexBuffer& vbo, std::vector<AttributeElement> attributes)
{
	glGenVertexArrays(1, &m_buffer);
	glBindVertexArray(m_buffer);

	vbo.Bind();

	unsigned int stride = 0;
	for (auto attribute: attributes)
		stride += attribute.size;
	
	unsigned int offset = 0;

	for (int i = 0; i < attributes.size(); i++) 
	{
		glEnableVertexAttribArray(i);
		glVertexAttribPointer(i, attributes[i].count, attributes[i].type, GL_FALSE, stride, (GLvoid*)offset);
		offset += attributes[i].size;
	}
}

VertexArray::~VertexArray()
{
}

void VertexArray::Bind() 
{
	glBindVertexArray(m_buffer);
}

void VertexArray::Unbind()
{
	glBindVertexArray(0);
}