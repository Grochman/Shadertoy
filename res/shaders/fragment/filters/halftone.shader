#version 330 core

#define PI 3.14159265359

in vec2 v_tex_coord;

uniform float u_time;
uniform vec2 u_resolution;
uniform sampler2D u_texture;

void main()
{
	int pixels_per_dot = 16;
	float pixel_render_factor = .8;
	float dots_per_row = u_resolution.x / float(pixels_per_dot);
	float dot_size = float(pixels_per_dot) / u_resolution.x;

	vec2 tex_coord = v_tex_coord;

	float speed = u_time*0.02;
	vec2 tex_coord_idx = vec2(floor(tex_coord / dot_size));
	vec2 offset = vec2(tex_coord_idx.y, tex_coord_idx.x);
	offset = (step(1., mod(offset, 2.))-0.5) * fract(speed) * 2;
	offset.x *= step(1., mod(speed*dots_per_row, 2));
	offset.y *= (1-step(1., mod(speed*dots_per_row, 2)));
	
	tex_coord += offset;

    vec2 to_center = mod(tex_coord, dot_size) - 0.5*dot_size; 
	vec2 center = tex_coord - to_center;
	
	center -= offset;
	

	vec3 mean_brightness = textureLod(u_texture, center, log(pixels_per_dot)).rgb; // sampling
	mean_brightness = vec3((mean_brightness.r+mean_brightness.g+mean_brightness.b)/3);
	

	float dist = length(to_center);
	float r = mean_brightness.x * dot_size * pixel_render_factor;
	float color = step(dist, r);
	
	gl_FragColor = vec4(vec3(color), 1.0);
}