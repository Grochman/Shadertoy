float rect(in vec2 st, in vec4 corners)
{
    return step(corners.x, st.x) * step(corners.y, st.y) * step(1.-corners.z, 1.-st.x) * step(1.-corners.w, 1.-st.y);
}

float rectfloor(in vec2 st, in vec4 corners)
{
    return floor(1-(corners.x-st.x)) * floor(1-(corners.y-st.y)) * floor(1-(st.x-corners.z)) * floor(1-(st.y-corners.w));
}

float rect(in vec2 st, in vec2 center, in vec2 sides)
{
    sides = sides/2;
    return rect(st, vec4(center.x-sides.x, center.y-sides.y, center.x+sides.x, center.y+sides.y));
}

float border(in vec2 st, in float width, in vec4 corners)
{
    return rect(st, corners)*(1 - rect(st, vec4(corners.xy+width, corners.zw-width)));
}

float border(in vec2 st, in float width, in vec2 center, in vec2 sides)
{
    return rect(st, center, sides)*(1 - rect(st, center, sides - width));
}

float circle(in vec2 st, in vec2 center, in float r)
{
    float dist = distance(st, center);    
    return step(dist, r);
}


float circle(in vec2 st, in vec2 center, in float r, in float s)
{
    float dist = distance(st, center);    
    return smoothstep(dist,dist+s, r);
}

float ring(vec2 st, vec2 center, float r, float depth)
{
    return circle(st,center, r) * (1-circle(st, center, r-depth));
}
