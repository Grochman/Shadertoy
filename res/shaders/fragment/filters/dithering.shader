#version 330 core

in vec2 v_tex_coord;

uniform vec2 u_resolution;
uniform sampler2D u_texture;

vec4 M = vec4(0.,0.5,0.75,0.25);

void main()
{
    float lum_levels = 2;
    float delta = 1/lum_levels;
    vec2 tex_coord = v_tex_coord;    
    
    vec3 tex_color = texture(u_texture, v_tex_coord).rgb;
    vec3 tex_grayscale = vec3((tex_color.r+tex_color.g+tex_color.b)/3); //tex_color;

    int idx = int(mod(tex_coord.y*u_resolution.y,2)*2 + mod(tex_coord.x*u_resolution.x,2));
    tex_grayscale += 1/lum_levels * (M[idx] - 0.5);

    tex_grayscale = floor(tex_grayscale/delta) * delta + delta/2;

    gl_FragColor = vec4(tex_grayscale, 1.);  
};
