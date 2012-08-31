class Talker
  def initialize(listener)
    @listener = listener
  end

  def say(message, *args, &block)
    @listener.send(message, *args, &block)
  end
end
