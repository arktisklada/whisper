# Whisper

A pub/sub crystal library, inspired by the ancient Chinese game of Whisper

## Installation

Include Whisper in your `shard.yml`:

```yaml
dependencies:
  whisper:
    github: arktisklada/whisper
```

## Example Usage

```crystal
require "whisper"

class SampleListener
  include Whisper::Listener

  def test
    puts "SampleListener#test"
  end
end

class Broadcast
  include Whisper::Broadcaster

  def trigger_listener
    broadcast(test)
  end
end

b = Broadcast.new
b.subscribe(SampleListener.new)
b.trigger_listener
```

this outputs `"SampleListener#test"`

## Contributing

1. Fork it ( https://github.com/arktisklada/whisper/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
