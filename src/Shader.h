#pragma once
#include <string>

class Shader
{
	std::string m_vertex_shader_path;
	std::string m_fragment_shader_path;
	std::string m_vertex_shader;
	std::string m_fragment_shader;
	
	unsigned int m_program;

	std::string ReadShader(std::string& path) const;
	std::string ParseInclude(const std::string& directive) const;
	unsigned int CompileShader(unsigned int type, const std::string& source) const;
	
	void CreateShader();

public:
	Shader(std::string vertex_shader_path, std::string fragment_shader_path);
	void Bind();
	void Unbind();
	void SetUniform2f(std::string name, float v0, float v1);
	void SetUniform1f(std::string name, float v0);
	void SetUniform1i(std::string name, int v0);
	~Shader();
};

