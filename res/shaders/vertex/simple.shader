#version 330 core

layout(location = 0) in vec4 position;
layout(location = 1) in vec2 tex_cord;

out vec2 v_tex_cord;

void main()
{
    gl_Position = position;
    v_tex_cord = tex_cord;
};
