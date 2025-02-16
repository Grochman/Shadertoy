#version 330 core

#define PI 3.14159265359
   
#include "transform.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

float woblycircle(in vec2 st, in vec2 center, in float r, float t){
    vec2 d = st - center;
    float theta = atan(d.y,d.x);
    theta = (theta)*30+PI/10+t; 
    
    float dist = distance(st, center) + sin(theta)*0.01;    
    return step(dist, r);
}

float woblyring(vec2 st, vec2 center, float r, float depth, float t){
    return woblycircle(st,center, r, t) * (1-woblycircle(st, center, r-depth, t));
}

float random(vec2 st){
    return fract(sin( dot(st.xy, vec2(12.234234,24.2342) ) )* 100000);
}

vec2 rotateTile(vec2 st, float index){
    if (index > 0.75) {
        st = vec2(1.0) - st;
    } else if (index > 0.5) {
        st = vec2(1.0-st.x,st.y);
    } else if (index > 0.25) {
        st = 1.0-vec2(1.0-st.x,st.y);
    }
    return st;
}

void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
    
    vec3 color = vec3(0.);

    st *=3.;
    
    vec2 ipos = floor(st);
    vec2 fpos = fract(st);
    
    vec2 tile = rotateTile(fpos, random(ipos));
    //tile = fpos;
    float c1 = woblyring(tile, vec2(0.), 0.55, 0.1, u_time);
    float c2 = woblyring(tile, vec2(1.), 0.55, 0.1, u_time);

    
    color += vec3(c1+c2);
    gl_FragColor = vec4(color, 1.0);  
};
