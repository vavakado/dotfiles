#version 110

precision highp float;

uniform sampler2D u_texture;
uniform vec2 u_resolution;

float DITHER_MATRIX[16];

void initDitherMatrix() {
    DITHER_MATRIX[0] = 0.0; DITHER_MATRIX[1] = 8.0; DITHER_MATRIX[2] = 2.0; DITHER_MATRIX[3] = 10.0;
    DITHER_MATRIX[4] = 12.0; DITHER_MATRIX[5] = 4.0; DITHER_MATRIX[6] = 14.0; DITHER_MATRIX[7] = 6.0;
    DITHER_MATRIX[8] = 3.0; DITHER_MATRIX[9] = 11.0; DITHER_MATRIX[10] = 1.0; DITHER_MATRIX[11] = 9.0;
    DITHER_MATRIX[12] = 15.0; DITHER_MATRIX[13] = 7.0; DITHER_MATRIX[14] = 13.0; DITHER_MATRIX[15] = 5.0;
}

vec3 dither(vec3 color, vec2 uv) {
    int x = int(mod(uv.x * u_resolution.x, 4.0));
    int y = int(mod(uv.y * u_resolution.y, 4.0));
    float threshold = DITHER_MATRIX[y * 4 + x] / 16.0;
    
    vec3 quantized = floor(color * 15.0 + threshold) / 15.0;
    return quantized;
}

void main() {
    initDitherMatrix();
    vec2 uv = gl_FragCoord.xy / u_resolution;
    vec3 color = texture2D(u_texture, uv).rgb;
    
    vec3 dithered = dither(color, uv);
    
    gl_FragColor = vec4(dithered, 1.0);
}
