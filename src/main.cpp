#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>
#include <string>

#include "error_check.h"
#include "VertexBuffer.h"
#include "IndexBuffer.h"
#include "Renderer.h"
#include "Shader.h"

#define WINDOW_HEIGHT 600
#define WINDOW_WIDTH 600


int main(void)
{
    GLFWwindow* window;

    if (!glfwInit())
        return -1;

    window = glfwCreateWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Hello World", NULL, NULL);
    if (!window)
    {
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);

    if (glewInit()!=GLEW_OK)
        return -1;
    std::cout << glGetString(GL_VERSION) << std::endl;
    
    glEnable(GL_DEBUG_OUTPUT);
    glDebugMessageCallback(messageCallback, 0);

    float possitions[] = {
        -1.0f, -1.0f,
         1.0f, -1.0f,
         1.0f,  1.0f,
        -1.0f,  1.0f
    };
    unsigned int indices[] = {
        0, 1, 2,
        2, 3, 0
    };
   
    VertexBuffer vb(possitions, sizeof(possitions));

    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 2, 0);

    IndexBuffer ib(indices, sizeof(indices) / sizeof(unsigned int));
    
    //-----------------------------------------------------------------------
    std::string square = "res/shaders/vertex/simple.shader";
    
    std::string mandelbrot = "res/shaders/fragment/mandelbrot_set.shader";
    std::string julia = "res/shaders/fragment/julia_set.shader";
    std::string sphere = "res/shaders/fragment/sphere.shader";
    std::string loading = "res/shaders/fragment/loading.shader";
    
    std::string dots =  "res/shaders/fragment/dots.shader";
    std::string cross = "res/shaders/fragment/cross.shader";
    std::string wobly = "res/shaders/fragment/wobly_tiles.shader";
    
    std::string playground = "res/shaders/fragment/playground.shader";
    //-----------------------------------------------------------------------

    Shader shader(square, julia);

    Renderer renderer(window, shader);
    renderer.run();

    glfwTerminate();
    return 0;
}