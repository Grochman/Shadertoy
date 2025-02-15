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
    
    vec2 pos = vec2(0.5) - st;

    float r = length(pos)*2.5;

    float a = atan(pos.y,pos.x);
    float f = cos(a*sin(u_time)*10 + u_time);
    vec3 color = vec3(step(f, r));
    gl_FragColor = vec4(color, 1.0);  
};
