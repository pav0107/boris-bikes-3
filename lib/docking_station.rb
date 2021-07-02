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
    # fail "All bikes are broken" if bikes[-1].broken?
    # bikes.pop
    bikes.reverse.each do |bike|
      unless bike.broken?
        return bikes.delete(bike)
      end
    end

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


