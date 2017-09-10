$InstrumentType = {
  :GUITAR => "Guitar",
  :BANJO => "Banjo",
  :DOBRO => "Dobro",
  :FIDDLE => "Fiddle",
  :BASS => "Bass",
  :MANDOLIN => "Mandolin"
}

$Builder = {
  :FENDER => "Fender",
  :MARTIN => "Martin",
  :GIBSON => "Gibson",
  :COLLINGS => "Collings",
  :OLSON => "Olson",
  :RYAN => "Ryan",
  :PRS => "PRS",
}

$Wood = {
  :INDIAN_ROSEWOOD => "Indian Rosewood",
  :BRAZILIAN_ROSEWOOD => "Brazilian Rosewood",
  :MAHOGANY => "Mahogany",
  :MAPLE => "Maple",
  :COCOBOLO => "Cocobolo",
  :CEDAR => "Cedar",
  :ADIRONDACK => "Adirondack",
  :ALDER => "Alder",
  :SITKA => "Sitka",
}

$Type = {
  :ACOUSTIC => "acoustic",
  :ELECTRIC => "electric",
}

$Style = {
  :A => "A style",
  :F => "F style",
}

class InstrumentSpec
  include Enumerable
  
  def initialize(properties = nil)
    if properties == nil
      @properties ||= {}
    else
      @properties = properties
    end
  end
  
  def each()
    @properties.each{|k ,v|
      yield k, v
    }
  end
  
  def getProperty(propertyName)
    @properties[propertyName]
  end

  def getProperties()
    @properties
  end

  def matches(otherSpec)
    otherSpec.each {|k, v|
      if @properties[k] != v
        return false
      end
      return true
    }
  end
end

class Instrument
  def initialize(serialNumber, price, spec)
    @serialNumber = serialNumber
    @price = price
    @spec = spec
  end

  def getSerialNumber()
    @serialNumber
  end

  def getPrice()
    @price
  end

  def setPrice(newPrice)
    @price = newPrice
  end

  def getSpec()
    @spec
  end
end

class Inventory
  def initialize()
    @inventory ||= []
  end

  def addInstrument(serialNumber, price, spec)
    @inventory << Instrument.new(serialNumber, price, spec)
  end

  def get(serialNumber)
    @inventory.each {|instrument|
      if instrument.getSerialNumber() == serialNumber
        return instrument
      end
    }
    return nil
  end

  def search(searchSpec)
    matchingInstruments ||= []
    @inventory.each {|instrument|
      if (instrument.getSpec().matches(searchSpec))
        matchingInstruments << instrument
      end
    }
    return matchingInstruments
  end
end

def initializeInventory(inventory)
  inventory.addInstrument("11277", 3999.95, InstrumentSpec.new(
    {
      "instrumentType" => $InstrumentType[:GUITAR],
      "builder" => $Builder[:COLLINGS],
      "model" => "CJ",
      "type" => $Type[:ACOUSTIC],
      "numStrings" => 6,
      "topWood" => $Wood[:INDIAN_ROSEWOOD],
      "backWood" => $Wood[:SITKA],
    }
  ))

  inventory.addInstrument("122784", 5495.95, InstrumentSpec.new(
    {
      "builder" => $Builder[:MARTIN],
      "model" => "D-18",
      "topWood" => $Wood[:MAHOGANY],
      "backWood" => $Wood[:ADIRONDACK],
    }
  ))

  inventory.addInstrument("V95693", 1499.95, InstrumentSpec.new(
    {
      "builder" => $Builder[:FENDER],
      "model" => "Stratocastor",
      "type" => $Type[:ELECTRIC],
      "topWood" => $Wood[:ALDER],
      "backWood" => $Wood[:ALDER],
    }
  ))

  inventory.addInstrument("V9512", 1549.95, InstrumentSpec.new(
    {
      "builder" => $Builder[:FENDER],
      "model" => "Stratocastor",
      "type" => $Type[:ELECTRIC],
      "topWood" => $Wood[:ALDER],
      "backWood" => $Wood[:ALDER],
    }
  ))

  inventory.addInstrument("70108276", 2295.95, InstrumentSpec.new(
    {
      "builder" => $Builder[:GIBSON],
      "model" => "Les Paul",
      "topWood" => $Wood[:MAPLE],
      "backWood" => $Wood[:MAPLE],
    }
  ))

  inventory.addInstrument("82765501", 1890.95, InstrumentSpec.new(
    {
      "model" => "SG '61 Reissue",
      "topWood" => $Wood[:MAHOGANY],
      "backWood" => $Wood[:MAHOGANY],
    }
  ))

  inventory.addInstrument("9019920", 5495.99, InstrumentSpec.new(
    {
      "instrumentType" => $InstrumentType[:MANDOLIN],
      "type" => $Type[:ACOUSTIC],
      "model" => "F-5G",
      "backWood" => $Wood[:MAPLE],
      "topWood" => $Wood[:MAPLE],
    }
  ))

  inventory.addInstrument("8900231", 2945.95, InstrumentSpec.new(
    {
      "instrumentType" => $InstrumentType[:BANJO],
      "model" => "RB-3 Wreath",
      "numStrings" => 5,
    }
  ))
end

def main(argv)
  inventory = Inventory.new()
  initializeInventory(inventory)

  properties ||= {}
  whatBryanLikes = InstrumentSpec.new(
    {
      "builder" => $Builder[:GIBSON],
      "backWood" => $Wood[:MAPLE],
    }
  )

  matchingInstruments = inventory.search(whatBryanLikes)
  if (!matchingInstruments.empty?)
    puts "Bryan, you might like these instruments:"
    matchingInstruments.each {|instrument|
      spec = instrument.getSpec()
      puts "We have a #{spec.getProperty('instrumentType')} with the following properties:"
      
      spec.getProperties().each {|k, v|
        next if k == "instrumentType"
        puts "    #{k}: #{v}"
      }
      
      puts "  You can have this #{spec.getProperty('instrumentType')} for $ #{instrument.getPrice()}\n---"
    }
  else
    puts "Sorry, Bryan, we have nothing for you."
  end
end

main(ARGV)

