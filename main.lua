local tex = graphics.newTexture( { type="canvas", width=display.actualContentWidth, height=display.actualContentHeight } )

-- Create main canvas
local canvas = display.newImageRect(
    tex.filename,  -- "filename" property required
    tex.baseDir,   -- "baseDir" property required
    display.actualContentWidth,
    display.actualContentHeight
)

canvas.x = display.contentCenterX
canvas.y = display.contentCenterY
 
-- Set background color to be applied if texture is cleared
local group = display.newGroup()
local bg = display.newRect(group, 0, 0, display.actualContentWidth, display.actualContentHeight)
bg:setFillColor(0.5, 0.7, 0.2)
bg.fill = {type = "image", filename = "img.jpg"}
tex:draw( bg )

local circles = {}
for i = 1, 10, 1 do
    local nxt = #circles + 1
    circles[nxt] = display.newCircle (group, math.random(-160, 160), math.random(-160, 160), 15)
    circles[nxt]:setFillColor(math.random(255)/255, math.random(255)/255, math.random(255)/255)  
end

local circ = display.newCircle(group, 0, 0, 32 )

local poly = display.newPolygon(group, 0, 0, {0,-55,14,-18,52,-18,22,8,32,45,0,22,-32,45,-22,8,-52,-18,-14,-18} )
poly:setFillColor( 0.2, 1, 0.2 )

tex:draw(group)

tex:invalidate()
 
-- Function to restore texture on resume
local function onSystemEvent( event )
    if ( event.type == "applicationResume" ) then
        tex:invalidate( "cache" )
    end
end

timer.performWithDelay(800, function()
 
    require ("effect")
    canvas.fill.effect = "filter.custom.shockwave"
    canvas.fill.effect.startTime = system.getTimer()/1000
    canvas.fill.effect.force = 0.05
  
    local centerX = display.contentCenterX/display.actualContentWidth
    local centerY = display.contentCenterY/display.actualContentHeight

    canvas.fill.effect.posX = -0.5 + math.random() * 2 -- range between (-0.5 -> 1.5)
    canvas.fill.effect.posY = math.random()-- range between (0 -> 1)
end, 100)
