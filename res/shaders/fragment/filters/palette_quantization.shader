#version 330 core

in vec2 v_tex_coord;

uniform vec2 u_resolution;
uniform sampler2D u_texture;

const int COLOR_COUNT = 5;
vec3 palette1[COLOR_COUNT] = {vec3(38,70,83), vec3(42,157,143), vec3(233,196,106), vec3(244,162,97), vec3(231,111,81)};
vec3 palette2[COLOR_COUNT] = {vec3(111, 29, 27), vec3(187, 148, 87), vec3(67, 40, 24), vec3(153, 88, 42), vec3(255, 230, 167)};
vec3 palette3[COLOR_COUNT] = {vec3(120, 0, 0), vec3(193, 18, 31), vec3(253, 240, 213), vec3(0, 48, 73), vec3(102, 155, 188)};

void main()
{
    vec3 tex_color = texture(u_texture, v_tex_coord).rgb;
    
    vec3 palette[COLOR_COUNT] = palette2;
    
    int min_idx = 0;
    float min_val = 100;
    
    for(int i = 0; i < COLOR_COUNT; i++)
    {
        palette[i] /= 255;    
        float dist = distance(tex_color, palette[i]);
        
        min_idx = int(mix(min_idx, i, 1.0 - step(min_val, dist)));
        min_val = min(min_val, dist);
    }
    tex_color = palette[min_idx];

    gl_FragColor = vec4(tex_color, 1.);  
};
