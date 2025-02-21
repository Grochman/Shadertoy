#version 330 core

in vec2 v_tex_coord;

uniform vec2 u_resolution;
uniform sampler2D u_texture;



void main()
{
    float std = 1;
    int kernel_size = int(ceil(6*std)) + 1;
    float pixel = 1/u_resolution;
    
    float filter[kernel_size*kernel_size] = 

    vec2 tex_coord = v_tex_coord;    
	vec2 start = v_tex_coord - vec2(floor(float(kernel_size)/2.)*pixel);

    
    vec3 tex_color = gaussian_blur(kernel_size, start, pixel);

    gl_FragColor = vec4(tex_grayscale, 1.);  
};
