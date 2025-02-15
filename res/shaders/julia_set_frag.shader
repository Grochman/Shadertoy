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
