#version 330 core

#define PI 3.14159265359
         
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
   
    float max = 0.5;
    float r = (sin(u_time)+1./max)*max*0.5;
    
    float time = u_time * 4;

    vec2 pos_b = vec2(sin(time), cos(time));
    pos_b = (pos_b+1./r)*r*0.5;
    
    vec2 pos_w = vec2(sin(time+PI), cos(time+PI)); 
    pos_w = (pos_w+1./r)*r*0.5;   

    float pct = pow(distance(st,pos_b),distance(st,pos_w));
    
    vec3 color =  vec3(pct);
   
    gl_FragColor = vec4(color, 1.0);  
};
