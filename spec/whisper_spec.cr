require "./spec_helper"

class TestListener
  include Whisper::Listener

  def test_listener(text)
    "TestListener#test_listener"
  end
end

class TestBroadcaster
  include Whisper::Broadcaster

  def do_you_work?(text)
    broadcast(test_listener, text)
  end
end

# it "broadcasts to subscribed events" do
#   text = "It works!"
#   broadcaster = TestBroadcaster.new
#   listener = TestListener.new
#   broadcaster.subscribe(listener)
#   received = broadcaster.do_you_work?(text)
# end
