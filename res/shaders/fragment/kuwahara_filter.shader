#version 330 core

#define PI 3.14159265359

in vec2 v_tex_coord;

uniform vec2 u_resolution;
uniform sampler2D u_texture;

float avg(int square_size, vec2 start, float pixel){
	vec2 tex_coord = start;
	float avg = 0;
	for(int i = 0; i < square_size; i++)
	{
		tex_coord = start + vec2(0.0 , float(i) * pixel);
		for(int j = 0; j < square_size; j++)
		{
			tex_coord.x += pixel;
			vec3 c = texture(u_texture, tex_coord).rgb;
			avg += (c.r+c.g+c.b)*0.33;
		}
	}
	return avg / float(square_size*square_size);
}

float std(int square_size, vec2 start, float pixel, float avg){
	vec2 tex_coord = start;
	float std = 0;
	for(int i = 0; i < square_size; i++)
	{
		tex_coord = start + vec2(0.0 , float(i) * pixel);
		for(int j = 0; j < square_size; j++)
		{
			tex_coord.x += pixel;
			vec3 c = texture(u_texture, tex_coord).rgb;
			std += pow((c.r+c.g+c.b)*0.33-avg, 2);
		}
	}
	std /= square_size*square_size;
	std = sqrt(std);
	return std;
}

void main()
{	
	vec4 avg = vec4(0.);
	vec4 std = vec4(0.);

	float pixel = 1./u_resolution.x;
	
	int kernel_size = 13; //should be odd int;
	
	int square_size = int(ceil(float(kernel_size)/2.));

	//calculate avg and std for each square
	vec2 start = v_tex_coord;
	avg.x = avg(square_size, start, pixel);
	std.x = std(square_size, start, pixel, avg.x);
	
	start = v_tex_coord - vec2(floor(float(kernel_size)/2.)*pixel, 0.);
	avg.y = avg(square_size, start, pixel);
	std.y = std(square_size, start, pixel, avg.y);
	
	start = v_tex_coord - vec2(0., floor(float(kernel_size)/2.)*pixel);
	avg.z = avg(square_size, start, pixel);
	std.z = std(square_size, start, pixel, avg.z);
	
	start = v_tex_coord - vec2(floor(float(kernel_size)/2.)*pixel);
	avg.w = avg(square_size, start, pixel);
	std.w = std(square_size, start, pixel, avg.w);
	
	//get mean value of smallest std
	float min_std = min(std.x, std.y);
	min_std = min(min_std, std.z);
	min_std = min(min_std, std.w);

	float color = avg.x;
	if(std.y == min_std)
		color = avg.y;
	else if(std.z == min_std)
		color = avg.z;
	else if(std.w == min_std)
		color = avg.w;
		
	gl_FragColor = vec4(vec3(color), 1.0);
}