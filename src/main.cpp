#include <GL/glew.h>
#include <GLFW/glfw3.h>

#include <iostream>
#include <string>
#include <vector>

#include "error_check.h"
#include "VertexBuffer.h"
#include "IndexBuffer.h"
#include "Renderer.h"
#include "Shader.h"
#include "Texture.h"
#include "VertexArray.h"
#include "FrameBuffer.h"

#define WINDOW_HEIGHT 600
#define WINDOW_WIDTH 600

void fps(double t1, double t2) {
    double delta = abs(t2 - t1);
    double fps = 1 / delta;
    std::cout << fps << std::endl;
}

int main(void)
{
    GLFWwindow* window;
    double mousexpos, mouseypos;

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
    //   position     texture
        -1.0f, -1.0f, 0.f, 0.0f,
         1.0f, -1.0f, 1.f, 0.0f,
         1.0f,  1.0f, 1.f, 1.0f,
        -1.0f,  1.0f, 0.f, 1.0f,
    };
    unsigned int indices[] = {
        0, 1, 2,
        2, 3, 0
    };
   
    VertexBuffer vbo(possitions, sizeof(possitions));
    VertexArray vao(vbo, { {2,sizeof(float)*2, GL_FLOAT},{2, sizeof(float)*2,GL_FLOAT} });
    IndexBuffer ibo(indices, sizeof(indices) / sizeof(unsigned int)); 
    
    //-----------------------------------------------------------------------
    std::string default_vert = "res/shaders/vertex/default.shader";
    std::string default_frag = "res/shaders/fragment/default.shader";

    std::string mandelbrot = "res/shaders/fragment/mandelbrot_set.shader";
    std::string julia = "res/shaders/fragment/julia_set.shader";
    std::string sphere = "res/shaders/fragment/sphere.shader";
    std::string loading = "res/shaders/fragment/loading.shader";
    
    std::string halftone = "res/shaders/fragment/filters/halftone.shader";
    std::string halftone_color = "res/shaders/fragment/filters/halftone_color.shader";
    std::string kuwahara = "res/shaders/fragment/filters/kuwahara_filter.shader";
    std::string palette = "res/shaders/fragment/filters/palette_quantization.shader";
    std::string luminacence = "res/shaders/fragment/filters/luminacence_quantization.shader";
    std::string dithering= "res/shaders/fragment/filters/dithering.shader";
    //-----------------------------------------------------------------------

    Shader shader(default_vert, julia);
    Shader post_shader(default_vert, dithering);
    
    Texture texture("res/textures/test.png");
    
    FrameBuffer fbo(WINDOW_WIDTH, WINDOW_HEIGHT);
    
    shader.Bind();
    shader.SetUniform2f("u_resolution", float(WINDOW_WIDTH), float(WINDOW_HEIGHT));
    Renderer renderer(shader, vao, ibo);
    
    post_shader.Bind();
    post_shader.SetUniform2f("u_resolution", float(WINDOW_WIDTH), float(WINDOW_HEIGHT));
    Renderer post_renderer(post_shader, vao, ibo);
    
    float t1 = 0;
    float t2 = 0;
    while (!glfwWindowShouldClose(window))
    {
        t2 = t1;
        t1 = glfwGetTime();
        //        fps(t1, t2);
        
        shader.Bind();
        texture.Bind();
        shader.SetUniform1i("u_texture", 0);
        shader.SetUniform1f("u_time", t1);
        glfwGetCursorPos(window, &mousexpos, &mouseypos);
        shader.SetUniform2f("u_mouse", mousexpos, mouseypos);
        
        fbo.Bind();
        glClear(GL_COLOR_BUFFER_BIT);
        
        renderer.draw();

        post_shader.Bind();        
        fbo.BindTexture();
        post_shader.SetUniform1i("u_texture", 0);
        post_shader.SetUniform1f("u_time", t1);
        post_shader.SetUniform2f("u_mouse", mousexpos, mouseypos);

        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        post_renderer.draw();
        
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}