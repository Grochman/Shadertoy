#version 330 core

#define PI 3.14159265359

#include "utility.shader"

in vec2 v_tex_cord;

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform sampler2D u_texture;

void main()
{
    
    vec4 tex_color = texture(u_texture, v_tex_cord);
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec2 mp = u_mouse/u_resolution;
    mp.y = 1-mp.y;
    
    vec3 color = vec3(0.);
    
    st *= 10;
    vec2 ipos = floor(st);
    vec2 fpos = fract(st);

    color += vec3(random(ipos));
    gl_FragColor = tex_color*vec4(color, 1.);  
};
