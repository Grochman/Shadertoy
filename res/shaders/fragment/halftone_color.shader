#version 330 core

#define PI 3.14159265359

#include "transform.shader"

in vec2 v_tex_coord;

uniform vec2 u_resolution;
uniform sampler2D u_texture;

void main()
{
	int pixels_per_dot = 8;
	float dots_per_row = u_resolution.x / float(pixels_per_dot);
	float dot_size = float(pixels_per_dot) / u_resolution.x;

	vec2 tex_coord = v_tex_coord;
	vec2 tex_coord_r = rotate(tex_coord, PI/4);
	vec2 tex_coord_g = rotate(tex_coord, PI/8);
	vec2 tex_coord_b = rotate(tex_coord, PI/1);
	
    vec2 to_center_r = mod(tex_coord_r, dot_size) - 0.5*dot_size; 
	vec2 center_r = tex_coord_r - to_center_r;
	center_r = rotate(center_r, -PI/4);

	vec2 to_center_g = mod(tex_coord_g, dot_size) - 0.5*dot_size; 
	vec2 center_g = tex_coord_g - to_center_g;
	center_g = rotate(center_g, -PI/8);

	vec2 to_center_b = mod(tex_coord_b, dot_size) - 0.5*dot_size; 
	vec2 center_b = tex_coord_b - to_center_b;
	center_b = rotate(center_b, -PI/1);

	float mean_color_r = textureLod(u_texture, center_r, log(pixels_per_dot)).r;
	float mean_color_g = textureLod(u_texture, center_g, log(pixels_per_dot)).g;
	float mean_color_b = textureLod(u_texture, center_b, log(pixels_per_dot)).b;
	

	float dot_render_factor = 0.75;

	float distr = length(to_center_r);
	float rr = mean_color_r * dot_size * dot_render_factor;
	float red = step(distr, rr);
	
	float distg = length(to_center_g);
	float rg = mean_color_g * dot_size * dot_render_factor;
	float green = step(distg, rg);
	
	float distb = length(to_center_b);
	float rb = mean_color_b * dot_size * dot_render_factor;
	float blue = step(distb, rb);
	
	gl_FragColor = vec4(red, green, blue, 1.0);
}