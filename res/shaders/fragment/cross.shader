#version 330 core

#define PI 3.14159265359
   
#include "shapes.shader"
#include "transform.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

float woblycircle(in vec2 st, in vec2 center, in float r, float t){
    vec2 d = st - center;
    float theta = atan(d.y,d.x); //angle
    theta  *= 100; 
    
    float dist = distance(st + sin(theta), center);    
    return step(dist, r);
}

float woblyring(vec2 st, vec2 center, float r, float depth){
    return circle(st,center, r) * (1-circle(st, center, r-depth));
}


void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec2 mp = u_mouse/u_resolution;
    mp.y = 1-mp.y;
    
    vec3 color = vec3(0.);

    float c1 = woblycircle(st, vec2(.5), 0.3, u_time);
    //float c2 = ring(st, vec2(1.), 0.55, 0.1);

    
    color += vec3(c1);
    gl_FragColor = vec4(color, 1.0);  
};
