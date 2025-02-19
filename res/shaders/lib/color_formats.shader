vec3 rgb2hsv(vec3 rgb)
{
    vec3 hsv = vec3(0);

    float cmax = max(rgb.r, rgb.g);
    cmax = max(cmax, rgb.b);
    
    float cmin = min(rgb.r, rgb.g);
    cmin = min(cmin, rgb.b);
    
    float delta = cmax - cmin;
    
    if(delta==0)
        hsv.x = 0;
    else if(cmax==rgb.r)
        hsv.x = (rgb.g -rgb.b)/delta;
    else if(cmax==rgb.g)
        hsv.x = (rgb.b -rgb.r)/delta+2;
    else if(cmax==rgb.b)
        hsv.x = (rgb.r -rgb.g)/delta+4;
    
    hsv.z = cmax;
    
    if(hsv.z != 0)
        hsv.y = delta/hsv.z;

    return hsv;
}

vec3 hsv2rgb(vec3 hsv)
{
    hsv.x = mod(hsv.x,6);

    float alfa = hsv.z * (1 - hsv.y);
    float beta = hsv.z * (1 - (hsv.x - floor(hsv.x)) * hsv.y);
    float gamma = hsv.z * (1 - (1 - (hsv.x - floor(hsv.x)))*hsv.y);

    vec3 rgb = vec3(hsv.z, alfa, beta);

    if(hsv.x < 1)
        rgb = vec3(hsv.z, gamma, alfa);
    else if(hsv.x < 2)
        rgb = vec3(beta, hsv.z, alfa);
    else if(hsv.x < 3)
        rgb = vec3(alfa, hsv.z, gamma);
    else if(hsv.x < 4)
        rgb = vec3(alfa, beta, hsv.z);
    else if(hsv.x < 5)
        rgb = vec3(gamma, alfa, hsv.z);

    return rgb;
}
