#pragma once
#include <string>
#include <GLFW/glfw3.h>
#include "Shader.h"

class Renderer
{
	GLFWwindow* m_window;
	int m_window_w;
	int m_window_h;
	
	Shader& m_shader;

	void updateMousePos();
	void updateTime();
public:
	Renderer(GLFWwindow* window,Shader& shader);
	void run();
	~Renderer();
};

