class Repeater
  def initialize(listener)
    @listener = listener
  end

  def method_missing(method_name, *args, &block)
    @listener.send(method_name, *args, &block)
  rescue
    super
  end

  def respond_to?(method_name)
    true
  end
end
