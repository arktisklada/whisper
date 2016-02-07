module Whisper
  # This module should be included with all listener classes.
  #
  # ex:
  # class SampleListener
  #   include Whisper::Listener
  #   ...
  # end
  module Listener
    # This is included to allow listeners with different handler methods and signatures
    macro method_missing(name, args, block)
    end
  end

  # This module should be included with any class that broadcasts a message
  # Broadcasters gain 2 methods: `subscribe` and `broadcast`.
  #
  # `subscribe` adds a constructed listener object to the object's list of subscriptions
  # `broadcast` triggers the event flow, and performs the broadcasted method on any listener that has implemented the method with a similar signature
  #
  # ex:
  # class SampleBroadcaster
  #   include Whisper::Broadcaster
  #   ...
  # end
  #
  # sample_broadcaster = SampleBroadcaster.new
  # sample_broadcaster.subscribe(SampleListener.new)
  module Broadcaster
    def initialize
      @_subscriptions = [] of Whisper::Subscription
    end

    # Adds a new listener to the collection of subscriptions
    # Accepts any class, and each class type will be added only once
    def subscribe(listener : T)
      if !@_subscriptions.any? { |s| s.listener.is_a? typeof(listener) }
        @_subscriptions << Subscription.new(listener)
      end
    end

    # Call the event method on any listener that responds to the method
    # Any additional arguments passed when calling `broadcast` will be passed through.
    # Listener methods can have different signatures based on the calling broadcast
    macro broadcast(event, *args)
      @_subscriptions.each do |s|
        if s.listener.responds_to? :{{event}}
          s.listener.{{event}}({{*args}})
        end
      end
    end
  end

  # The internal class that holds the listener object
  class Subscription
    getter :listener

    def initialize(listener)
      @listener = listener
    end
  end
end
