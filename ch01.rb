
class Guitar
  attr_accessor :serialNumber, :price, :spec
  def initialize(serialNumber, price, spec)
    @serialNumber = serialNumber
    @price = price
    @spec = spec
  end
end

class GuitarSpec
  attr_accessor :builder, :model, :type, :numStrings, :backWood, :topWood
  def initialize(builder, model, type, numStrings, backWood, topWood)
    @builder = builder
    @model = model
    @type = type
    @numStrings = numStrings
    @backWood = backWood
    @topWood = topWood
  end

  def matches(otherSpec)
    return false if (@builder != otherSpec.builder)
    return false if ( (@model != nil) && (@model != "") && (@model.downcase != otherSpec.model.downcase) )
    return false if (@type != otherSpec.type)
    return false if (@numStrings != otherSpec.numStrings)
    return false if (@backWood != otherSpec.backWood)
    return false if (@topWood != otherSpec.topWood)
    return true
  end
end

class Inventory
  def initialize
    @guitars ||= []
  end

  def addGuitar(serialNumber, price, spec)
    @guitars << Guitar.new(serialNumber, price, spec)
  end

  def getGuitar(serialNumber)
    @guitars.each {|guitar|
      if (@guitar.getSerialNumber == serialNumber)
        return guitar
      end
    }
    return nil
  end

  def search(searchSpec)
    matchingGuitars ||= []
    @guitars.each{|guitar|
      if(guitar.spec.matches(searchSpec))
        matchingGuitars << guitar
      end
    }
    return matchingGuitars
  end
end

$type ||= {}
$type[:acoustic] = "ACOUSTIC"
$type[:electric] = "ELECTRIC"

$wood ||= {}
$wood[:indian_rosewood] = "INDIAN_ROSEWOOD"
$wood[:brazilian_rosewood] = "BRAZILIAN_ROSEWOOD"
$wood[:mahogany] = "MAHOGANY"
$wood[:maple] = "MAPLE"
$wood[:cocobolo] = "COCOBOLO"
$wood[:cedar] = "CEDAR"
$wood[:adirondack] = "ADIRONDACK"
$wood[:alder] = "ALDER"
$wood[:sitka] = "SITKA"

$builder ||= {}
$builder[:fender] = "FENDER"
$builder[:martin] = "MARTIN"
$builder[:gibson] = "GIBSON"
$builder[:collings] = "COLLINGS"
$builder[:olson] = "OLSON"
$builder[:ryan] = "RYAN"
$builder[:prs] = "PRS"

def initializeInventory(inventory)
  inventory.addGuitar("11277", 3999.95, 
    GuitarSpec.new($builder[:collings], "CJ", $type[:acoustic], 6, $wood[:indian_rosewood], $wood[:sitka]));
  inventory.addGuitar("V95693", 1499.95, 
    GuitarSpec.new($builder[:fender], "Stratocastor", $type[:electric], 6, $wood[:alder], $wood[:alder]));
  inventory.addGuitar("V9512", 1549.95, 
    GuitarSpec.new($builder[:fender], "Stratocastor", $type[:electric], 6, $wood[:alder], $wood[:alder]));
  inventory.addGuitar("122784", 5495.95, 
    GuitarSpec.new($builder[:marin], "D-18", $type[:acoustic], 6, $wood[:mahogany], $wood[:adirondack]));
  inventory.addGuitar("76531", 6295.95, 
    GuitarSpec.new($builder[:marin], "OM-28", $type[:acoustic], 6, $wood[:brazilian_rosewood], $wood[:adirondack]));
  inventory.addGuitar("70108276", 2295.95, 
    GuitarSpec.new($builder[:gibson], "Les Paul", $type[:electric], 6, $wood[:mahogany], $wood[:mahogany]));
  inventory.addGuitar("82765501", 1890.95, 
    GuitarSpec.new($builder[:gibson], "SG '61 Reissue", $type[:electric], 6, $wood[:mahogany], $wood[:mahogany]));
  inventory.addGuitar("77023", 6275.95, 
    GuitarSpec.new($builder[:marin], "D-28", $type[:acoustic], 6, $wood[:brazilian_rosewood], $wood[:adirondack]));
  inventory.addGuitar("1092", 12995.95, 
    GuitarSpec.new($builder[:olson], "SJ", $type[:acoustic], 12, $wood[:indian_rosewood], $wood[:cedar]));
  inventory.addGuitar("566-62", 8999.95, 
    GuitarSpec.new($builder[:ryan], "Cathedral", $type[:acoustic], 12, $wood[:cocobolo], $wood[:cedar]));
  inventory.addGuitar("6 29584", 2100.95, 
    GuitarSpec.new($builder[:prs], "Dave Navarro Signature", $type[:electric], 6, $wood[:mahogany], $wood[:maple]));
end

def main(argv)
  inventory = Inventory.new
  initializeInventory(inventory)

  whatErinLikes = GuitarSpec.new($builder[:fender], "Stratocastor", $type[:electric], 6, $wood[:alder], $wood[:alder]);
  matchingGuitars = inventory.search(whatErinLikes)
  if (!matchingGuitars.empty?)
    puts "Erin, you might like these guitars:"
    matchingGuitars.each{|guitar|
      spec = guitar.spec
      puts "  We have a #{spec.builder} #{spec.model} #{spec.type} guitar:"
      puts "#{spec.backWood}  back and sides,"
      puts "#{spec.topWood} top."
      puts "You can have it for only #{guitar.price}!"
    }
  else
    puts "Sorry, Erin, we have nothing for you."
  end
end

main(ARGV)
