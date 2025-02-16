#version 330 core

#define PI 3.14159265359
   
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

float cross(in vec2 st, in vec2 center, in float r, float t){
    vec2 d = st - center;
    float theta = atan(d.y,d.x);
    theta  *= 200; 

    float dist = distance(st + sin(theta+t), center);    
    return smoothstep(0., dist, r);
}

void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
    
    vec3 color = vec3(0.);
    
    float c1 = cross(st, vec2(.5), 0.3, -u_time);
    
    color = vec3(c1);
    gl_FragColor = vec4(color, 1.0);  
};
