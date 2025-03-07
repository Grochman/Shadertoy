#version 330 core

#include "color_formats.shader"

in vec2 v_tex_coord;

uniform vec2 u_resolution;
uniform sampler2D u_texture;

void main()
{   
    gl_FragColor = texture(u_texture, v_tex_coord);
};
