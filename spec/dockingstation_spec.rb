require "docking_station"

describe DockingStation do  
  describe '#release_bike' do
    it 'raises an error when there are no bikes available' do
      expect {subject.release_bike}.to raise_error "No bikes available"
    end
  end

  describe '#dock' do
    it 'raises an error when full' do
      DockingStation::DEFAULT_CAPACITY.times do
        subject.dock(Bike.new)
      end
      expect { subject.dock Bike.new }.to raise_error "Docking station full"
    end
  end

  it "bike is working" do
    bike1 = Bike.new
    subject.dock(bike1)
    bike = subject.release_bike
    expect(bike.working?).to eq(true) 
  end

  it { is_expected.to respond_to(:dock).with(1).argument }
  it { is_expected.to respond_to(:bikes) }
  it "docks something" do
    bike = Bike.new
    expect(subject.dock(bike)).to eq subject.bikes
  end
  it "returns docked bikes" do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.bikes.pop).to eq bike
  end

end
