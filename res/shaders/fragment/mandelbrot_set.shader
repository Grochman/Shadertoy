#version 330 core
       
#define PI 3.14159265359

#include "fractal_coloring.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st = st * 3 - vec2(2.1, 1.5);
    
    vec2 z = vec2(0., 0.);
    int i = 0;
    int maxIter = 100;
    for (; i < maxIter; i++) {
        z = vec2(z.x * z.x - z.y * z.y, 2 * z.x * z.y) + st;
        if(length(z) > 2.0) break;
    }

    vec3 color1 = colorOut(z);
    vec3 color2 = colorTime(float(i)/float(maxIter));
    gl_FragColor = vec4(color2 * color1, 1.);
};
