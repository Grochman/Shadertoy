#version 330 core

#define PI 3.14159265359

in vec2 v_tex_coord;

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform sampler2D u_texture;

void main()
{
	int pixels_per_dot = 8;
	float dots_per_row = u_resolution.x / float(pixels_per_dot);
	float dot_size = float(pixels_per_dot) / u_resolution.x;

    vec2 to_center = mod(v_tex_coord, dot_size) - 0.5*dot_size; 
	vec2 center = v_tex_coord - to_center;
	
	vec3 mean_brightness = textureLod(u_texture, center, log(pixels_per_dot)).rgb; // sampling
	mean_brightness = vec3((mean_brightness.r+mean_brightness.g+mean_brightness.b)/3);
	
	float dist = length(to_center);
	float r = mean_brightness.x * dot_size;
	float color = step(dist, r);
	
	gl_FragColor = vec4(vec3(color), 1.0);
}