
class Bark
  def initialize(sound)
    @sound = sound
  end

  def getSound()
    @sound
  end
  
  def ==(otherBark)
    if @sound.downcase() == otherBark.getSound.downcase()
      return true
    else
      return false
    end
  end
end

class BarkRecognizer
  def initialize(door)
    @door = door
  end

  def recognize(bark)
    puts("   BarkRecognizer: Heard a '#{bark.getSound()}'")
    @door.getAllowedBarks.each { |allowedBark|
      if allowedBark == bark
        @door.open()
        return
      end
    }
    puts("This dog is not allowed.")
  end
end

class DogDoor
  def initialize()
    @allowedBarks ||= []
    @open = false
  end

  def <<(bark)
    @allowedBarks << bark
  end

  def getAllowedBarks()
    return @allowedBarks
  end

  def open()
    puts("The dog door opens.")
    @open = true
    sleep(5)
  end
  
  def close()
    puts ("The dog door closes.")
    @open = false
  end

  def open?()
    return @open
  end
end


class Remote
  def initialize(door)
    @door = door
  end

  def pressButton()
    puts ("Pressing the remote control button...")
    if @door.open?
      @door.close()
    else
      @door.open()
    end
  end
end


def main(argv)
  door = DogDoor.new()
  door << Bark.new("rowlf")
  door << Bark.new("rooowlf")
  door << Bark.new("rawlf")
  door << Bark.new("woof")
  recognizer = BarkRecognizer.new(door)
  remote = Remote.new(door)

  puts("Bruce starts barking.")
  recognizer.recognize(Bark.new("Rowlf"))

  puts("\nBruce has gone outside...")

  sleep(10)

  puts("\nBruce all done...")
  puts("...but he's stuck outside!")

  smallDogBark = Bark.new("yip")
  puts("A small dog starts barking.")
  recognizer.recognize(smallDogBark)

  sleep(5)

  puts("\nBruce starts barking.")
  recognizer.recognize(Bark.new("Rowlf"))

  puts("\nBruce's back inside...")
end

main(ARGV)
