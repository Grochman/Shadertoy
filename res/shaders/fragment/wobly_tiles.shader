#version 330 core

#define PI 3.14159265359
   
#include "transform.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

float woblycircle(in vec2 st, in vec2 center, in float r, float t, int dir){
    vec2 d = st - center;
    float theta = atan(d.y,d.x);
    theta = (theta+t*(0.5-step(1., dir))) * 20; 
    
    float dist = distance(st, center) + sin(theta)*0.01;    
    return step(dist, r);
}

float woblyring(vec2 st, vec2 center, float r, float depth, float t, int dir){
    return woblycircle(st,center, r, t, dir) * (1-woblycircle(st, center, r-depth, t, dir));
}


void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
    
    vec3 color = vec3(0.);

    st *=3.;
    st = fract(st);

    float c1 = woblyring(st, vec2(0.), 0.55, 0.1, u_time, 1);
    float c2 = woblyring(st, vec2(1.), 0.55, 0.1, u_time, 0);

    
    color += vec3(c1+c2);
    gl_FragColor = vec4(color, 1.0);  
};
