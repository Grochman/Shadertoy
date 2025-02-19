#version 330 core

#include "color_formats.shader"

in vec2 v_tex_coord;

uniform vec2 u_resolution;
uniform sampler2D u_texture;

void main()
{
    vec3 tex_color = texture(u_texture, v_tex_coord).rgb;
    float lum_levels = 8;
    float delta = 1/lum_levels;
    
    vec3 tex_hsv = rgb2hsv(tex_color);
    tex_hsv.z = floor(tex_hsv.z/delta) * delta + delta/2;
    tex_color = hsv2rgb(tex_hsv);

    gl_FragColor = vec4(tex_color, 1.);  
};
