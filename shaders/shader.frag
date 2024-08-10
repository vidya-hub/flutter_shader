#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float u_time;

out vec4 FragColor;

void main(){
    vec2 pixel  = FlutterFragCoord() / uSize;
    FragColor = vec4(0.0,abs((pixel.x)/(u_time)),0.0,1);
}
