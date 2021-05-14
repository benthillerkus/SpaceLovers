// https://en.wikipedia.org/wiki/Smoothstep
static float smoothstep(float edge0, float edge1, float x) {
    //Scale, bias and saturate x to 0..1 range
    x = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0); 
    //Evaluate polynomial
    return x * x * (3 - 2 * x);
}

static float smootherstep(float edge0, float edge1, float x) {
    //Scale, and clamp x to 0..1 range
    x = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
    //Evaluate polynomial
    return x * x * x * (x * (x * 6 - 15) + 10);
}

static float clamp(float x, float lowerlimit, float upperlimit) {
    if(x < lowerlimit)
        x = lowerlimit;
    if(x > upperlimit)
        x = upperlimit;
    return x;
}