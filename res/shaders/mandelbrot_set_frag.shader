#version 330 core
       
#define PI 3.14159265359

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

vec3 colorDist(vec2 z){
    float r = length(z);
    return (1-vec3(step(2.,r))) * vec3(r*5.5,r*r*2.3,r*r*r);
}

vec3 colorOut(vec2 z){
    return vec3(step(1.,length(z)));
}

vec3 colorTime(float t){
    return 1-(vec3(cos(t+10), cos(t*52), sin(t*PI))+1)/2;
}

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
