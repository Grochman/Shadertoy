#version 330 core
         
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main()
{
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    vec2 um = u_mouse.xy / u_resolution.xy;
    gl_FragColor = vec4(abs(sin(u_time)),um.y,uv.x,1.0);
    //gl_FragColor = vec4(abs(um.x-uv.x),abs(um.y-uv.y),0.4,1.0);
};
