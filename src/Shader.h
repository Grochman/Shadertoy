#pragma once
#include <string>
#include <unordered_map>

class Shader
{
	std::string m_vertex_shader_path;
	std::string m_fragment_shader_path;
	std::string m_vertex_shader;
	std::string m_fragment_shader;
	
	unsigned int m_program;

	std::unordered_map<std::string, int> uniforms;

public:
	Shader(std::string vertex_shader_path, std::string fragment_shader_path);
	~Shader();
	void Bind();
	void Unbind();
	void SetUniform2f(std::string name, float v0, float v1);
	void SetUniform1f(std::string name, float v0);
	void SetUniform1i(std::string name, int v0);

private:
	std::string ReadShader(std::string& path) const;
	std::string ParseInclude(const std::string& directive) const;
	unsigned int CompileShader(unsigned int type, const std::string& source) const;

	void CreateShader();
};

