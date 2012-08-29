load 'lib/echo.rb'

describe Echo do
  let(:listener) { stub.as_null_object }
  subject(:echo) { Echo.new(listener) }

  it "sends arbitrary messages that it receives to its listener" do
    listener.should_receive(:foobar)
    echo.foobar
  end

  it "responds to everything" do
    echo.should respond_to :foobar
  end
end
