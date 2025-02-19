#version 330 core

#define PI 3.14159265359
   
#include "shapes.shader"
#include "transform.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;


void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
    
    vec3 color = vec3(0.);

    st*=7.;
    float speed = u_time;

    st.x += (step(1., mod(st.y, 2.))-0.5)*fract(speed)*2* step(1., mod(speed, 2));
    st.y += (step(1., mod(st.x, 2.))-0.5)*fract(speed)*2* (1-step(1., mod(speed, 2)));
    
    st = fract(st);

    vec2 center = vec2(0.5);

    float s = circle(st, center, 0.3);
    color += vec3(s);

    gl_FragColor = vec4(color, 1.0);  
};
