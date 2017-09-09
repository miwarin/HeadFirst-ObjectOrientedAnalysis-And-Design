class DogDoor
  def initialize()
    @open = false
  end
  
  def open()
    puts "The dog door opens."
    @open = true
  end

  def close()
    puts "The dog door closes."
    @open = false
  end

  def isOpen()
    @open
  end
end

class Remote
  def initialize(door)
    @door = door
  end

  def pressButton()
    puts "Pressing the remote control button..."
    if @door.isOpen
      @door.close()
    else
      @door.open()
      sleep(5)
      @door.close()
    end
  end
end

class BarkRecognizer
  def initialize(door)
    @door = door
  end

  def recognize(bark)
    puts "   BarkRecognizer: Heard a '#{bark}'"
    @door.open()
  end
end

def main(argv)
  door = DogDoor.new()
  recognizer = BarkRecognizer.new(door)
  remote = Remote.new(door)

  puts "Fido starts barking."
  recognizer.recognize("Woof")

  puts "\nFido has gone outside..."
  puts "\nFido's all done..."
  sleep(10)
  puts "...but he's stuck outside!"
  puts "\nFido starts barking."
  
  recognizer.recognize("Woof")

  puts "\nFido's back inside..."

end

main(ARGV)
