require "docking_station"

describe DockingStation do  
  describe '#release_bike' do
    it 'raises an error when there are no bikes available' do
      expect {subject.release_bike}.to raise_error "No bikes available"
    end

    it 'raises an error when there are no working bikes' do
      bike = Bike.new
      bike.report_broken
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error "All bikes are broken"
    end

    it 'releases the next available working bike' do
      working_bike = Bike.new
      broken_bike = Bike.new
      broken_bike.report_broken
      subject.dock(working_bike)
      subject.dock(broken_bike)
      expect(subject.release_bike).to eq(working_bike)
    end
  end

  describe 'dock' do
    it 'raises an error when full' do
      subject.capacity.times { subject.dock(Bike.new) }
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
  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  describe 'initialization' do
    it 'has a variable capacity' do
      docking_station = DockingStation.new(50)
      50.times { docking_station.dock Bike.new }
      expect{ docking_station.dock Bike.new }.to raise_error 'Docking station full'
    end
  end

  # describe 'initialization' do
  #   let(:bike) { Bike.new }
  #   it 'defaults capacity' do
  #     DockingStation::DEFAULT_CAPACITY.times do
  #       subject.dock(bike)
  #     end
  #     expect{ subject.dock(bike) }.to raise_error 'Docking station full'
  #   end
  # end

end
