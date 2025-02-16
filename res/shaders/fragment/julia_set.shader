#version 330 core

#define PI 3.14159265359

#include "fractal_coloring.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;


void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st = st*4.-2.;
    
    vec2 mp = u_mouse/u_resolution;
    mp.y = 1-mp.y;
    mp = mp-0.5;
  
    vec2 c = vec2(-.1, 0.65);
    c = mp;

    vec2 z = vec2(st);
    
    int maxiter = 100;
    int i = 0;
    for (; i < maxiter; i++) {
        z = vec2(z.x * z.x - z.y * z.y, 2. * z.x * z.y) + c;
        if(length(z) > 2.) break;
    }

    vec3 color1 = colorOut(z);
    vec3 color2 = colorTime(float(i)/float(maxiter));
    gl_FragColor = vec4( color2 * color1,1.0);
};
