
--# debugM
--# debugM
debugM = class()

function debugM:init(x)
-- you can accept and set parameters here
    setContext(screen)
    self.x = x
end

function debugM:draw( value )
    output.clear()
    parameter.clear()
-- Codea does not automatically call 
    parameter.number("Resolution",1,50,7)
    parameter.number("ZPosition",1,750,30)
    parameter.number("Ratio",1,10,1.5)
    parameter.boolean("TextureChange",false,texset)
    parameter.boolean("STARDAND",false,stdmode)
    parameter.action("Hide Parameters",hdps)
    parameter.action("Reset Screen",a)
--parameter.action("Generate JSON",generateJson)
    print("DebugStatus:Active.\nIf you want to stop Debug,plz restart.")
end
--Texture set
function texset( value2 )
    if value2 == true then
        tex1 = readImage("Project:3D-grass0")
    end
end
--Stardand Mode
function stdmode( value3 )
    if value3 == true then
        displayMode(STANDARD)
        elseif value3 == false then
        displayMode(OVERLAY)
    end
end
--Reset Step.1
function a()
    print("Are you sure?")
    parameter.clear()
    parameter.action("I Said Reset!",reset)
    parameter.action("Nevermind...",debugM.draw)
end
--Reset
function reset()
        localTextures.draw()
end
--Fullscreen
function hdps()
    displayMode(FULLSCREEN)
end
--[[Generate Json
function generateJson()
    local clr = {colorSolution}
    local str = json.encode(clr,exception)
end]]
--Touch Function
function debugM:touched(touch)
    -- Codea does not automatically call this method
    if displayMode == FULLSCREEN then
        if touch.tapCount == 2 and touch.state == ENDED then
            displayMode(OVERLAY)
        end
    end
end
--# reset
localTextures = class()

function localTextures:init(x)
    -- you can accept and set parameters here
    self.x = x
end

function localTextures:draw()
    -- Codea does not automatically call this method
    parameter.clear()
    m1.shader = shader()
    background(0,0,0,255)
    output.clear()
end

function localTextures:touched(touch)
    -- Codea does not automatically call this method
end

--# Main
--# Main
--[[Shader from Shadertoy.com,Optimized by WaterproofPaper and @gaigai613
Version 1.1
]]

function setup() 
    print("--Mystery Mountain--")
    print("--Shader from Shadertoy.com(@Dave_Hoskins),Reprint by Codea Bar,Optimized by Flat Team.")
    print("1.Do not use for commercial purposes. (C)Shadertoy.com.")
    print("2.You must keep these messages while you reprinting them.")
    print("3.Enjoy!")
    displayMode(OVERLAY)
    spriteMode(CORNER)
    parameter.boolean("Debug",false,Dbg)
    parameter.integer("Resolution",1,20,7)
    parameter.integer("ZPosition",10,500,30)
    parameter.integer("Ratio",1,10,2)
    parameter.integer("Speed",-5,5,1)
    parameter.watch("ElapsedTime")
    screen = image(WIDTH/Resolution,HEIGHT/Resolution)
    w,h = screen.width,screen.height
    tex1 = readImage("Project:3D-grass1") 
    m1 = mesh() 
    m1.shader=shader(f.vs,f.fs) 
    m1.shader.iChannel0 = tex1
    
    x,y,t,q = 2,2,1,1
    m1:addRect(WIDTH/x,HEIGHT/y,WIDTH/t,HEIGHT/q)
end 

function Dbg( value )
    y,q = 2.2,1.2
    if value == true then
        parameter.clear("Debug")
        output.clear()
        debugM.draw()
    end
end


function draw()
    debugM.touched()
    Fps = math.floor(1/DeltaTime)
 --[[   Fps = math.floor(1/DeltaTime)
    fpsClock = 0 + DeltaTime
    if fpsClock ~= 1 then
        fpsClock = fpsClock+DeltaTime
        elseif fpsClock == 1 then
        fpsClock = 0
        parameter.watch("Fps")
    end]]
screen = image(WIDTH/Resolution,HEIGHT/Resolution)
    m1.shader.iResolution = vec3(screen.width*Ratio,screen.height*Ratio,ZPosition)
setContext(screen)
    m1.shader.iGlobalTime = ElapsedTime*(Speed)
    m1:draw() 
setContext()
sprite(screen,0,0,WIDTH,HEIGHT)
    fontSize(30)
    font("Futura-MediumItalic")
    fill(0,0,0,255)
    text("Fps:"..Fps,WIDTH-50,HEIGHT-20)
end


f = {vs = [[ 
uniform mat4 modelViewProjection; 
attribute vec4 position; 
attribute vec4 color; 
attribute vec2 texCoord; 
//This is an output variable that will be passed to the fragment shader 
varying lowp vec4 vColor; 
varying highp vec2 vTexCoord; 
void main(){ 
//Pass the mesh color to the fragment shader 
vColor = color; 
vTexCoord = texCoord; 
//Multiply the vertex position by our combined transform 
gl_Position = modelViewProjection * position;}]], 



fs = [[
precision highp float;
uniform lowp sampler2D texture; 
uniform vec3 iResolution; // viewport resolution (in pixels) 
uniform float iGlobalTime; // shader playback time (in seconds) 
uniform lowp sampler2D iChannel0; // input channel. XX = 2D/Cube 
#define F +texture2D(iChannel0,.3+p.xz*(s+=s)/6e3,-99.)/s 
void main(){ 
vec4 p=vec4(gl_FragCoord.xy/iResolution.xy,1,1)-.5, d=p*.5, t; 
p.z += iGlobalTime*20.; d.y-=.2; 
for(float i=1.7;i>=0.;i-=.002) { 
float s=.5; 
//t=F+F+F+F+F+F; 
t = F+F+F+F+F+F; 
/*t+= texture2D(iChannel0,.3+p.xw*s/6e3,-99.)/s;s+=s; t+= texture2D(iChannel0,.3+p.xw*s/6e3,-99.)/s;s+=s; t+= texture2D(iChannel0,.3+p.xw*s/6e3,-99.)/s;s+=s; t+= texture2D(iChannel0,.3+p.xw*s/6e3,-99.)/s;s+=s; t+= texture2D(iChannel0,.3+p.xw*s/6e3,-99.)/s;s+=s; t+= texture2D(iChannel0,.3+p.xw*s/6e3,-99.)/s;s+=s;*/
gl_FragColor = vec4(1,.9,.8,9)+d.x-t*i; 
if(t.x>p.y*.01+1.3)break; 
p += d; }}
]]
}
--# colorSolution
colorSolution = class()

function colorSolution:init(x)
    -- you can accept and set parameters here
    self.x = x
end

function colorSolution:draw()
    -- Codea does not automatically call this method
    colorSolution = {
    color(255, 0, 0, 255),
    color(255,255,0,255),
    color(0,0,255,255),
    color(255,255,255,255),
    color(0,0,0,255)
    }
end

function colorSolution:touched(touch)
    -- Codea does not automatically call this method
end

--# localTextures
localTextures = class()

function localTextures:init(x)
    -- you can accept and set parameters here
    self.x = x
end

function localTextures:draw()
    -- Codea does not automatically call this method
    parameter.clear()
    m1.shader = shader()
    background(0,0,0,255)
    output.clear()
end

function localTextures:touched(touch)
    -- Codea does not automatically call this method
end

--# FPS
--# FPS
FPS = class()

function FPS:init(x)
    -- you can accept and set parameters here
    self.x = x
end

function FPS:draw()
    -- Codea does not automatically call this method
    Fps = math.floor(1/DeltaTime)
    local fpsClock = 0 + DeltaTime
    if fpsClock ~= 1 then
        local fpsClock = fpsClock + DeltaTime
        elseif fpsClock == 1 then
        local fpsClock = 0
        parameter.watch("Fps")
    end
end

function FPS:touched(touch)
    -- Codea does not automatically call this method
end
