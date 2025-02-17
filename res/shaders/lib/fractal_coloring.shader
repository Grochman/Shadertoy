vec3 colorDist(vec2 z)
{
    float r = length(z);
    return (1-vec3(step(2.,r))) * vec3(r*5.5,r*r*2.3,r*r*r);
}

vec3 colorOut(vec2 z)
{
    return vec3(step(1.,length(z)));
}

vec3 colorTime(float t)
{
    return 1-(vec3(cos(t+10), cos(t*52), sin(t*PI))+1)/2;
}