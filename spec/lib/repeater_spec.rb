load 'lib/repeater.rb'

describe Repeater do
  let(:listener) { stub.as_null_object }
  subject(:repeater) { Repeater.new(listener) }

  it "sends arbitrary messages that it receives to its listener" do
    listener.should_receive(:foobar)
    repeater.foobar
  end

  it "responds to everything" do
    repeater.should respond_to :foobar
  end
end
