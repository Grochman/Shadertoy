#include "functions.h"

void GLAPIENTRY messageCallback(GLenum source,
    GLenum type,
    GLuint id,
    GLenum severity,
    GLsizei length,
    const GLchar* message,
    const void* userParam) {
    std::cout << message << std::endl;
}


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

static unsigned int CreateShader(const std::string& vertexShader, const std::string& fragmentShader)
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

static std::string ParseInclude(const std::string& directive) {
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


static void updateMousePos(GLFWwindow* window, int mouseLocation) {
    double mousexpos, mouseypos;
    glfwGetCursorPos(window, &mousexpos, &mouseypos);
    glUniform2f(mouseLocation, float(mousexpos), float(mouseypos));
}

static void updateTime(int timeLocation) {
    float timeValue = glfwGetTime();
    glUniform1f(timeLocation, timeValue);
}

void run(GLFWwindow* window, const std::string& vertexShader, const std::string& fragmentShader) {
    int width, height;
    glfwGetWindowSize(window, &width, &height);
    
    unsigned int shader = CreateShader(vertexShader, fragmentShader);
    glUseProgram(shader);

    int timeLocation = glGetUniformLocation(shader, "u_time");
    int mouseLocation = glGetUniformLocation(shader, "u_mouse");
    int resolutionLocation = glGetUniformLocation(shader, "u_resolution");
    glUniform2f(resolutionLocation, float(width), float(height));

    while (!glfwWindowShouldClose(window))
    {
        updateTime(timeLocation);
        updateMousePos(window, mouseLocation);

        glClear(GL_COLOR_BUFFER_BIT);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, nullptr);
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glDeleteProgram(shader);
}