#include "functions.h"

static unsigned int CompileShader(unsigned int type, const std::string& source)
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

unsigned int CreateShader(const std::string& vertexShader, const std::string& fragmentShader)
{
    unsigned int program = glCreateProgram();
    unsigned int vs = CompileShader(GL_VERTEX_SHADER, vertexShader);
    unsigned int fs = CompileShader(GL_FRAGMENT_SHADER, fragmentShader);

    glAttachShader(program, vs);
    glAttachShader(program, fs);
    glLinkProgram(program);
    glValidateProgram(program);

    glDeleteShader(vs);
    glDeleteShader(fs);

    return program;
}

std::string ParseInclude(const std::string& directive) {
    int f = 0;
    int l = 0;
    for (int i = 7; i < directive.size(); i++) {
        if (directive[i] == '\"') {
            if (f == 0) { f = i+1; }
            else {
                l = i;
                break;
            }
        }
    }
    std::string filename = directive.substr(f, l-f);
    filename = "res/lib/" + filename;
    std::string content = ReadShader(filename.c_str());

    return content;
}

std::string ReadShader(const char* path) {
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
