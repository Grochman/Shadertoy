#include "Shader.h"
#include <GL/glew.h>
#include <fstream>
#include <iostream>


std::string Shader::ParseInclude(const std::string& directive) const
{
    int f = 0;
    int l = 0;
    for (int i = 7; i < directive.size(); i++) {
        if (directive[i] == '\"') {
            if (f == 0) { f = i + 1; }
            else {
                l = i;
                break;
            }
        }
    }
    std::string filename = directive.substr(f, l - f);
    filename = "res/shaders/lib/" + filename;
    std::string content = ReadShader(filename);

    return content;
}

std::string Shader::ReadShader(std::string& path) const
{
    std::ifstream file(path);

    if (!file.is_open()) {
        throw std::runtime_error("Failed to open file: " + std::string(path));
    }
    std::string shader = "";
    std::string line;
    while (getline(file, line)) {
        if (line.substr(0, 8) == "#include") shader += ParseInclude(line);
        else shader += line + '\n';
    }
    return shader;
}


unsigned int Shader::CompileShader(unsigned int type, const std::string& source) const
{
    unsigned int id = glCreateShader(type);
    const char* src = source.c_str();
    glShaderSource(id, 1, &src, nullptr);
    glCompileShader(id);

    int result;
    glGetShaderiv(id, GL_COMPILE_STATUS, &result);
    if (result == GL_FALSE) {
        int length;
        glGetShaderiv(id, GL_INFO_LOG_LENGTH, &length);
        char* message = (char*)alloca(length * sizeof(char));
        glGetShaderInfoLog(id, length, &length, message);
        std::cout << message << std::endl;

        glDeleteShader(id);

        return -1;
    }

    return id;
}

void Shader::CreateShader()
{
    m_program = glCreateProgram();
    unsigned int vs = CompileShader(GL_VERTEX_SHADER, m_vertex_shader);
    unsigned int fs = CompileShader(GL_FRAGMENT_SHADER, m_fragment_shader);

    glAttachShader(m_program, vs);
    glAttachShader(m_program, fs);
    glLinkProgram(m_program);
    glValidateProgram(m_program);

    glDeleteShader(vs);
    glDeleteShader(fs);
}

Shader::Shader(std::string vertex_shader_path, std::string fragment_shader_path)
    :m_vertex_shader_path(vertex_shader_path), m_fragment_shader_path(fragment_shader_path)
{
    m_vertex_shader = ReadShader(m_vertex_shader_path);
    m_fragment_shader = ReadShader(m_fragment_shader_path);
    CreateShader();
    Bind();
}

void Shader::Bind() 
{
    glUseProgram(m_program);
}

void Shader::Unbind() 
{
    glUseProgram(0);
}

Shader::~Shader() 
{
    glDeleteProgram(m_program);
}


void Shader::SetUniform2f(std::string name, float v0, float v1)
{
    int loc = glGetUniformLocation(m_program, name.c_str());
    glUniform2f(loc, v0, v1);
}
void Shader::SetUniform1f(std::string name, float v0)
{
    int loc = glGetUniformLocation(m_program, name.c_str());
    glUniform1f(loc, v0);
}