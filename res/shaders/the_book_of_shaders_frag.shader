#version 330 core

#define PI 3.14159265359
         
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

vec3 colorR = vec3(1.,0.0,0.);
vec3 colorO = vec3(0.54,0.2,0.0);
vec3 colorY = vec3(0.4,0.6,0.0);
vec3 colorG = vec3(0.0,1.,0.0);
vec3 colorB = vec3(0.,0.2,1.0);


float easeOutBounce(float x) {
    float n1 = 7.5625;
    float d1 = 2.75;

    if (x < 1 / d1) {
        return n1 * x * x;
    } else if (x < 2 / d1) {
        return n1 * (x -= 1.5 / d1) * x + 0.75;
    } else if (x < 2.5 / d1) {
        return n1 * (x -= 2.25 / d1) * x + 0.9375;
    } else {
        return n1 * (x -= 2.625 / d1) * x + 0.984375;
    }
}

float pcurve( float x, float a, float b ){
    float k = pow(a+b,a+b) / (pow(a,a)*pow(b,b));
    return k * pow( x, a ) * pow( 1.0-x, b );
}

vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix( vec3(1.0), rgb, c.y);
}


void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec2 mp = u_mouse/u_resolution;
    mp.y = 1-mp.y;
    vec2 center = vec2(0.5,0.5);
    center = fract(st*2);
    
    float dist = distance(st, center);
    dist += u_time*0.1;
    dist = abs(sin(dist*50));
    vec3 color = vec3(dist);
    
    gl_FragColor = vec4(color, 1.0);  
};
