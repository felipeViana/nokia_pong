local soundManager = {}

function soundManager.playSound(source)
  source:seek(0)
  source:play()
end

return soundManager
