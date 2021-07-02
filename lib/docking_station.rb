require_relative "bike"

class DockingStation

  DEFAULT_CAPACITY = 20

  attr_reader :capacity, :bikes
  
  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    fail 'No bikes available' if empty?

    i = bikes.length - 1
    while i >= 0
      if !bikes[i].broken?
        break
      else
        i -= 1
      end
    end

    fail 'All bikes are broken' if i < 0
    
    bikes.delete(bikes[i])
    
  end

  def dock(bike)
    fail 'Docking station full' if full?
    bikes << bike
  end

  private


  def full?
    bikes.count >= capacity
  end

  def empty?
    bikes.empty?
  end
  
end


