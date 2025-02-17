#pragma once
#include <string>

class Shader
{
	std::string m_vertex_shader_path;
	std::string m_fragment_shader_path;
	std::string m_vertex_shader;
	std::string m_fragment_shader;
	
	unsigned int m_program;

	std::string ReadShader(std::string& path);
	std::string ParseInclude(const std::string& directive);

	void CreateShader();
	unsigned int CompileShader(unsigned int type, const std::string& source);
public:
	Shader(std::string vertex_shader_path, std::string fragment_shader_path);
	void Bind();
	void Unbind();
	void SetUniform2f(std::string name, float v0, float v1);
	void SetUniform1f(std::string name, float v0);
	~Shader();
};

