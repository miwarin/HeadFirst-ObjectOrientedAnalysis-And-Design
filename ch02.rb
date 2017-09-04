
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

def main(argv)
    door = DogDoor.new
    remote = Remote.new(door)

    puts "Fido barks to go outside..."
    remote.pressButton()

    puts "\nFido has gone outside..."
    puts "\nFido's all done..."

    sleep(10)

    puts "...but he's stuck outside!"

    puts "\nFido starts barking..."
    puts "...so Gina grabs the remote control."
    remote.pressButton()

    puts "\nFido's back inside..."
end

main(ARGV)

