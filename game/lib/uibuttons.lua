local uibuttons = {}

uibuttons.list = {}

--- Registra un nuevo botón
-- @param btn table: {x, y, w, h, draw, onpress, userdata}
function uibuttons.register(btn)
  btn.pressed = false -- nuevo estado
  table.insert(uibuttons.list, btn)
end

--- Llama en love.draw()
function uibuttons.draw()
  for _, btn in ipairs(uibuttons.list) do
    if btn.draw then btn.draw(btn) end
  end
end

--- Llama en love.mousepressed/love.touchpressed
function uibuttons.handle_press(x, y)
  -- Recorre todos los botones registrados
  for i, btn in ipairs(uibuttons.list) do

    -- Obtiene el rectángulo del botón
    local bx, by, bw, bh
    -- si el botón tiene una función get_rect, úsala
    if btn.get_rect then
      bx, by, bw, bh = btn.get_rect()
    -- Si no, usa las propiedades x, y, w, h
    else
      bx, by, bw, bh = btn.x, btn.y, btn.w, btn.h
    end
    -- si x, y (cursor) está en el botón
    if x >= bx and x <= bx + bw and y >= by and y <= by + bh then
      -- el botón esta presionado

      print('boton ' .. tostring(i) .. ' pressed')
      btn.pressed = true
      -- si el botón tiene una función onpress, ejecutarla
      if btn.onpress then
        btn.onpress(btn)
      end
      return true
    end

  end -- termina la iteracion
  return false
end
--[[
  function uibuttons.handle_release(x, y)
    for _, btn in ipairs(uibuttons.list) do
      btn.pressed = false
    end
  end
]]

function uibuttons.handle_release(x, y)
  -- Recorre todos los botones registrados
  for i, btn in ipairs(uibuttons.list) do
    -- no ejecutar nada si el botón no se estaba pulsando antes
    -- if btn.pressed then
    if true then
      -- el boton ya no esta presionado
      btn.pressed = false
      -- Obtiene el rectángulo del botón
      local bx, by, bw, bh
      -- si el botón tiene una función get_rect, úsala
      if btn.get_rect then
        bx, by, bw, bh = btn.get_rect()
      -- Si no, usa las propiedades x, y, w, h
      else
        bx, by, bw, bh = btn.x, btn.y, btn.w, btn.h
      end
      -- si x, y (cursor) está en el botón...
      if x >= bx and x <= bx + bw and y >= by and y <= by + bh then
        -- el botón fue soltado dentro de su rango, lo cual nos dice que
        -- el usuario efectivamente quiso tocar el botón.
        -- si el botón tiene una función onrelease, ejecutarla
        print('boton ' .. tostring(i) .. ' released')

        if btn.onrelease then
          btn.onrelease(btn)
        end
        return true
      end
    end


  end -- termina la iteracion
  return false
end



return uibuttons
