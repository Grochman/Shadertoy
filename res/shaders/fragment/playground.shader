#version 330 core

#define PI 3.14159265359
   
#include "shapes.shader"
#include "transform.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

float random(vec2 st){
    return fract(sin( dot(st.xy, vec2(12.234234,24.2342) ) )* 100000);
}

void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec2 mp = u_mouse/u_resolution;
    mp.y = 1-mp.y;
    
    vec3 color = vec3(0.);
    
    st *= 10;
    vec2 ipos = floor(st);
    vec2 fpos = fract(st);

    color += vec3(random(ipos));
    
    gl_FragColor = vec4(color, 1.0);  
};
