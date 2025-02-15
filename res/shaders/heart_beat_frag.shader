#version 330 core

#define PI 3.14159265359
         
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

float circle(in vec2 st, in vec2 center, in float r){
    float dist = distance(st, center);    
    return step(dist, r);
}

float circle(in vec2 st, in vec2 center, in float r, in float s){
    float dist = distance(st, center);    
    return smoothstep(dist,dist+s, r);
}

void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec2 mp = u_mouse/u_resolution;
    mp.y = 1-mp.y;
    
    //heartbeat
    float time = fract(u_time);
    float t = step(time, 0.5)*(time*2.*PI);

    float t1 = (sin(t)*sin(t*3+2)+1)*0.125 + 0.15;
    
    float circle = circle(st, mp, t1);
    
    //fiinal color
    vec3 color = circle * vec3(1.,0.,0.);
   
    gl_FragColor = vec4(color, 1.0);  
};
