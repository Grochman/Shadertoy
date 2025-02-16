#version 330 core

#define PI 3.14159265359
   
#include "shapes.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;


void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec2 mp = u_mouse/u_resolution;
    mp.y = 1-mp.y;
    
    
    vec3 color = vec3(0.);
    vec3 bg = vec3(st.x,st.y,0.);

    vec2 pos = st;
    vec2 center = vec2(0.5);
    
    mat2 rotate = mat2(cos(u_time), -(sin(u_time)), sin(u_time), cos(u_time) );
    mat2 scale = mat2(cos(u_time), 0., 0., cos(u_time) );
    mat2 transform = rotate * scale;
    pos -= center;
    pos = transform * pos;
    pos += center;

    
    float rect1 = rect(pos, center, vec2(0.05,0.2));
    float rect2 = rect(pos, center, vec2(0.2,0.05));
    float cross = rect1+rect2;
    
    color = vec3(cross) + bg;
    
    gl_FragColor = vec4(color, 1.0);  
};
