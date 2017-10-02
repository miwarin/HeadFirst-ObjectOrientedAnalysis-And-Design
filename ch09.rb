
class Weapon  end

class Unit
  def initialize(id)
    @id = id
  end

  def getType()
    return @type
  end

  def setType(type)
    @type = type
  end

  def getName()
    return @name
  end

  def setName(name)
    @name = name
  end

  def getWeapons()
    return @weapons
  end
  
  def getId()
    return @id
  end
  
  def addWeapon(weapon)
    @weapons ||= []
    @weapons << weapon
  end
  
  def setProperty(property, value)
    @properties ||= {}
    @properties[property] = value
  end
  
  def getProperty(property)
    return nil if @properties == nil
    return @properties[property]
  end
end


class UnitTester
  def testType(unit, type, expectedOutputType)
    puts("\nTesting setting/getting the type property.")
    unit.setType(type)
    outputType = unit.getType()
    if (expectedOutputType == outputType)
      puts("Test passed")
    else
      puts("Test failed: #{outputType} didn't match #{expectedOutputType}")
    end
  end
  
  def testUnitSpecificProperty(unit, propertyName, inputValue, expectedOutputType)
    puts("\nTesting setting/getting a unit-specific property.")
    unit.setProperty(propertyName, inputValue)
    outputValue = unit.getProperty(propertyName)
    if (expectedOutputType == outputValue)
      puts("Test passed")
    else
      puts("Test failed: #{outputValue} didn't match #{expectedOutputType}")
    end
  end
  
  def testNonExistentProperty(unit, propertyName)
    puts("\nTesting getting a non-existent property's value.")
    outputValue = unit.getProperty(propertyName)
    if (outputValue == nil)
      puts("Test passed")
    else
      puts("Test failed with value of #{outputValue}")
    end
  end
end

def main(argv)
  tester = UnitTester.new()
  unit = Unit.new(1000)
  tester.testType(unit, "infantry", "infantry")
  tester.testUnitSpecificProperty(unit, "hitPoints", 25, 25)
  tester.testNonExistentProperty(unit, "strength")
end

main(ARGV)

