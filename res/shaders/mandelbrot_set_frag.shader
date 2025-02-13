#version 330 core
         
uniform float iTime;
        
void main()
{
    vec2 uv = gl_FragCoord.xy / vec2(600.0, 600.0);
    uv = uv * 3 - vec2(2.5, 1.5);
    uv.x = (uv.x - 0.5) / iTime + 0.5;
    uv.y = (uv.y - 0.5) / iTime + 0.5;

    vec2 z = vec2(0.0, 0.0);
    float r = 0.0;
    for (int i = 0; i < 200; i++) {
        float nx = z.x * z.x - z.y * z.y + uv.x;
        float ny = 2 * z.x * z.y + uv.y;
        z = vec2(nx,ny);
        if(length(z) > 2.0) { 
            r = 1.0;
            break;
        }  
    }
    gl_FragColor = vec4(r,0.0,0.0,1.0);
};
