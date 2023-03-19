local vector = require('vectorImage')
local gui = require('gui')
local graph = {}
function graph.create(x,y,w,h,bg,fg)
  local canvas = vector.newCanvas(x,y,w,h)
  canvas.points = {}
  canvas.lines = {}
  canvas:addShape(1,1,'rectangle',w,h,bg)
  local centerx = math.ceil(w/2)
  local centery = math.ceil(h/2)
  canvas:addShape(1,centery,'line',w,centery,fg)
  canvas:addShape(centerx,1,'line',centerx,h,fg)
  canvas.setPoint = function(canvas,x,y)
    local index = #canvas.points+1
    canvas.points[index] = {x=x,y=y}
    return index
  end
  canvas.centerx = centerx
  canvas.centery = centery
  canvas.fg = fg
  canvas.setLine = function(canvas,point1,point2)
    local index = #canvas.lines+1
    canvas.lines[index] = {point1,point2}
    return index
  end
  canvas.update = function(canvas)
    for i = 1, #canvas.shapes-3 do
      canvas.shapes[3+i] = nil
    end
    for i = 1, #canvas.lines do
      canvas:addShape(
      canvas.centerx-canvas.points[canvas.lines[i][1]].x*-1,
      canvas.centery-canvas.points[canvas.lines[i][1]].y,
      'line',
      canvas.centerx-canvas.points[canvas.lines[i][2]].x*-1,
      canvas.centery-canvas.points[canvas.lines[i][2]].y,
      canvas.fg)
    end
  end
  return canvas
end
return graph
