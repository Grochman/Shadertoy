#version 330 core

#define PI 3.14159265359
         
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;


float rect(in vec2 st, in vec4 corners){
    return step(corners.x, st.x) * step(corners.y, st.y) * step(1.-corners.z, 1.-st.x) * step(1.-corners.w, 1.-st.y);
}

float rectfloor(in vec2 st, in vec4 corners){
    return floor(1-(corners.x-st.x)) * floor(1-(corners.y-st.y)) * floor(1-(st.x-corners.z)) * floor(1-(st.y-corners.w));
}

float rect(in vec2 st, in vec2 center, in vec2 sides){
    sides = sides/2;
    return rect(st, vec4(center.x-sides.x, center.y-sides.y, center.x+sides.x, center.y+sides.y));
}

float border(in vec2 st, in float width, in vec4 corners){
    return rect(st, corners)*(1 - rect(st, vec4(corners.xy+width, corners.zw-width)));
}

float border(in vec2 st, in float width, in vec2 center, in vec2 sides){
    return rect(st, center, sides)*(1 - rect(st, center, sides - width));
}

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
    
    vec2 pos = vec2(0.5) - st;

    float r = length(pos)*2.5;

    float a = atan(pos.y,pos.x);
    float f = cos(a*sin(u_time)*10 + u_time);
    vec3 color = vec3(step(f, r));
    gl_FragColor = vec4(color, 1.0);  
};
