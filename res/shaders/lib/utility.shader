float random(vec2 st)
{
    return fract(sin( dot(st.xy, vec2(12.234234,24.2342) ) )* 100000);
}

float random(vec2 st, vec2 seed)
{
    return fract(sin( dot(st.xy, seed ) )* 100000);
}
