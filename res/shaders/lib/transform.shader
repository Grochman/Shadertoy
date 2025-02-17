vec2 rotate(vec2 st, float angle)
{
    st-=0.5;
    st = mat2(cos(angle), -sin(angle), sin(angle), cos(angle)) * st;
    st+=0.5;
    return st;
}

vec2 scale(vec2 st, float scale)
{
    st-=0.5;
    st *= mat2(scale, 0, 0, scale) * st;
    st+=0.5
    return st;
}

vec2 scale(vec2 st, vec2 scale)
{
    st-=0.5;
    st *= mat2(scale.x, 0, 0, scale.y) * st;
    st+=0.5
    return st;
}

vec2 translate(vec2 st, vec2 move)
{
    st-=0.5;
    st += move;
    st+=0.5
    return st;
}