#version 330 core

#define PI 3.14159265359
   
#include "shapes.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;    
    float t = (sin(u_time)+1)*0.5;

    vec3 color = vec3(0.);
    mat2 squish = mat2(1.,0.,0.,2.);
    vec2 center = vec2(0.5);
    st-=center;
    st = squish * st;
    st+=center;
    
    float rings[10];
    float R = 0.45;   
    
    for(int i = 1; i <=5; i++){
        float pos = abs(R-0.5)+ float(i) * 0.1;
        float r = sqrt(pow(R,2) - pow((0.5 - pos),2));   
       
        pos = -1/(t*pos*150) + pos;

        vec2 ring_center = vec2(0.5,pos);
        rings[i] = ring(st, ring_center, r, 0.01);
        color += vec3(rings[i]);
    }

    for(int i = 5; i <=10; i++){
        float pos = abs(R-0.5)+ float(i) * 0.1;
        float r = sqrt(pow(R,2) - pow((0.5 - pos),2));   

        pos = 1/(t*(abs(pos-1)*150)) + pos;
    
        vec2 ring_center = vec2(0.5,pos);
        rings[i] = ring(st, ring_center, r, 0.01);
        color += vec3(rings[i]);
    }

    float poles[10];
    squish = mat2(2.,0.,0.,1.);
    mat2 scale = mat2(.6,0.,0.,.6);
    squish *=scale;
    st-=center;
    st = squish * st;
    st+=center;
    
    for(int i = 1; i <=10; i++){
        float pos = abs(R-0.5)+ float(i) * 0.1;
        pos += (smoothstep(-1,1,sin((u_time+4)*0.5))-0.5)*3;
        
        float r = sqrt(pow(R,2) - pow((0.5 - pos),2));   
        vec2 ring_center = vec2(pos, 0.5);
        poles[i] = ring(st, ring_center, r, 0.004);
        color += vec3(poles[i]);
    }

    gl_FragColor = vec4(color, 1.0);  
};
