#version 330 core

in vec2 v_tex_coord;

uniform sampler2D u_texture;

void main()
{   
    gl_FragColor = texture(u_texture, v_tex_coord);
};
