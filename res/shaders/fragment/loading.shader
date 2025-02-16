#define PI 3.14159265359
    
#include "shapes.shader"

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;    
    
    float spinner = ring(st, vec2(0.5), 0.3, 0.1);
    
    vec2 d = st - 0.5;
    float theta = atan(d.y,d.x); //angle
    theta  = fract(((theta+PI)/(2*PI))-u_time/4); //normalize
    theta -= 0.1; //dim

    vec3 color =vec3(theta)*vec3(spinner);
    
    gl_FragColor = vec4(color, 1.0);  
};
