#version 330 core

#define PI 3.14159265359

#include "transform.shader"

in vec2 v_tex_coord;

uniform float u_time;
uniform vec2 u_resolution;
uniform sampler2D u_texture;

void main()
{
	int pixels_per_dot = 16;
	float dot_render_factor = 0.75;
	float dots_per_row = u_resolution.x / float(pixels_per_dot);
	float dot_size = float(pixels_per_dot) / u_resolution.x;

	vec2 tex_coord = v_tex_coord;
	vec2 tex_coord_r = rotate(tex_coord, PI/4);
	vec2 tex_coord_g = rotate(tex_coord, PI/8);
	vec2 tex_coord_b = rotate(tex_coord, PI/1);
	
	tex_coord_r.x += (u_time*0.05);
	tex_coord_g.x -= (u_time*0.03);
	tex_coord_b.y += (u_time*0.05);


    vec2 to_center_r = mod(tex_coord_r, dot_size) - 0.5*dot_size; 
	vec2 center_r = tex_coord_r - to_center_r;
	
	center_r.x -= (u_time*0.05);
	center_r = rotate(center_r, -PI/4);


	vec2 to_center_g = mod(tex_coord_g, dot_size) - 0.5*dot_size; 
	vec2 center_g = tex_coord_g - to_center_g;
	
	center_g.x += (u_time*0.03);
	center_g = rotate(center_g, -PI/8);


	vec2 to_center_b = mod(tex_coord_b, dot_size) - 0.5*dot_size; 
	vec2 center_b = tex_coord_b - to_center_b;
	
	center_b.y -= (u_time*0.05);
	center_b = rotate(center_b, -PI/1);

	

	float mean_color_r = textureLod(u_texture, center_r, log(pixels_per_dot)).r;
	float mean_color_g = textureLod(u_texture, center_g, log(pixels_per_dot)).g;
	float mean_color_b = textureLod(u_texture, center_b, log(pixels_per_dot)).b;
	

	
	float dist_r = length(to_center_r);
	float r_r = mean_color_r * dot_size * dot_render_factor;
	float red = step(dist_r, r_r);
	
	float dist_g = length(to_center_g);
	float r_g = mean_color_g * dot_size * dot_render_factor;
	float green = step(dist_g, r_g);
	
	float dist_b = length(to_center_b);
	float r_b = mean_color_b * dot_size * dot_render_factor;
	float blue = step(dist_b, r_b);
	
	gl_FragColor = vec4(red, green, blue, 1.0);
}