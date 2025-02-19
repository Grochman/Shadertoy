#version 330 core

#include "color_formats.shader"

in vec2 v_tex_coord;

uniform vec2 u_resolution;
uniform sampler2D u_texture;

vec4 M = vec4(-0.375,0.125,0.375,-0.125);

void main()
{
    float lum_levels = 2;
    float delta = 1/lum_levels;
    vec2 tex_coord = v_tex_coord;    
    
    vec3 tex_color = texture(u_texture, v_tex_coord).rgb;
    vec3 tex_grayscale = vec3((tex_color.r+tex_color.g+tex_color.b)/3);

    int idx = int(mod(tex_coord.y*u_resolution.y,2)*2 + mod(tex_coord.x*u_resolution.x,2));
    tex_grayscale += 1/lum_levels * M[idx] - 0.5/u_resolution.x;

    tex_grayscale = floor(tex_grayscale/delta) * delta + delta/2;

    gl_FragColor = vec4(tex_grayscale, 1.);  
};
