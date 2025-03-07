#version 330 core

#define PI 3.14159265359

in vec2 v_tex_coord;

uniform vec2 u_resolution;
uniform sampler2D u_texture;

void std_avg(int square_size, vec2 start, float pixel,out vec3 avg_color, out float std)
{
	vec2 pos;
	vec3 color_sum = vec3(0);
	float sum_of_squares = 0.;
	float count = float(square_size*square_size);
	for(int i = 0; i < square_size; i++)
	{
		for(int j = 0; j < square_size; j++)
		{
			pos = start + vec2(float(j), float(i))*pixel;
			vec3 c = texture(u_texture, pos).rgb;
			float intensity = (c.r + c.g + c.b)*0.3333;
			color_sum += c;
			sum_of_squares += intensity * intensity;
		}
	}
	avg_color = color_sum/count;
	float avg = 0.3333*(avg_color.r+avg_color.g+avg_color.b);
	std = sqrt(sum_of_squares/count - avg * avg);
}

void main()
{	
	vec3 avg_col_1 = vec3(0);
	vec3 avg_col_2 = vec3(0);
	vec3 avg_col_3 = vec3(0);
	vec3 avg_col_4 = vec3(0);
	
	vec4 std = vec4(0.);

	float pixel = 1./u_resolution.x;
	
	int kernel_size = 12;
	int square_size = kernel_size + 1;

	kernel_size = kernel_size * 2 + 1;

	//calculate avg and std for each square
	vec2 start = v_tex_coord;
	std_avg(square_size, start, pixel, avg_col_1, std.x);

	start = v_tex_coord - vec2(floor(float(kernel_size)/2.)*pixel, 0.);
	std_avg(square_size, start, pixel, avg_col_2, std.y);

	start = v_tex_coord - vec2(0., floor(float(kernel_size)/2.)*pixel);
	std_avg(square_size, start, pixel, avg_col_3, std.z);

	start = v_tex_coord - vec2(floor(float(kernel_size)/2.)*pixel);
	std_avg(square_size, start, pixel, avg_col_4, std.w);

	//get mean value of smallest std
	float min_std = min(std.x, std.y);
	min_std = min(min_std, std.z);
	min_std = min(min_std, std.w);

	vec3 color = avg_col_1;
	
	if(std.y == min_std)
		color = avg_col_2;
	else if(std.z == min_std)
		color = avg_col_3;
	else if(std.w == min_std)
		color = avg_col_4;
	
	//color = mix(color, avg_col_1, 1-step(min_std, std.x));
	//color = mix(color, avg_col_2, 1-step(min_std, std.y));
	//color = mix(color, avg_col_3, 1-step(min_std, std.z));
	//color = mix(color, avg_col_4, 1-step(min_std, std.w));

	gl_FragColor = vec4(vec3(color), 1.0);
}