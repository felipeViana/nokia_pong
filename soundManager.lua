local soundManager = {}

local sources = {}
function soundManager.play(source)
  -- remove all playing sounds
  for _, s in pairs(sources) do
    sources[s]:stop()
    sources[s] = nil
  end

  source:seek(0)
  source:play()
  sources[source] = source
end

return soundManager
