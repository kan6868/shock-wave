--[[
  *
        require "shockwave"
        object.fill.effect = "filter.custom.shockwave"
]]

local kernel = {}

kernel.language = "glsl"
kernel.category = "filter"

kernel.name = "shockwave"
kernel.isTimeDependent = true

kernel.vertexData   = {
  {
    name = "startTime",
    default = 0.1, 
    min = 0.1,
    max = 99999999999999.0,
    index = 0,
  },
  {
    name = "force",
    default = 0.05,
    min = 0.01,
    max = 100,
    index = 1
  },
  {
    name = "posX",
    default = 0.5,
    min = 0.01,
    max = 1,
    index = 2
  },
  {
    name = "posY",
    default = 0.5,
    min = 0.01,
    max = 1,
    index = 3
  }
}
kernel.fragment =
[[
    P_COLOR float force = CoronaVertexUserData.y;
    P_COLOR float size = 0.1;

    P_COLOR float thickness = 0.1;
    P_COLOR vec2 position = vec2(CoronaVertexUserData.z, CoronaVertexUserData.w); // Position
    P_COLOR vec4 FragmentKernel( P_UV vec2 texCoord )
    {
        P_COLOR float ratio = 0.5;
        P_COLOR vec2 scale_uv = (texCoord - vec2(0.5, 0.0))/ vec2(ratio, 1.0) + vec2(0.5, 0.0);
        P_COLOR float mask = (1.0 - smoothstep(size - 0.1, CoronaTotalTime - CoronaVertexUserData.x + size, length(scale_uv - position))) *
            smoothstep(CoronaTotalTime - CoronaVertexUserData.x + size - thickness - 0.1, 
            CoronaTotalTime - CoronaVertexUserData.x + size - thickness, length(scale_uv - position));
        P_COLOR vec2 disp = normalize(scale_uv - position) * ( force) * mask;

        P_COLOR vec4 color = texture2D( CoronaSampler0, texCoord - disp);
        
        return CoronaColorScale(color);
      }
]]

graphics.defineEffect( kernel )