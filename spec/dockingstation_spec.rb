require "docking_station"

describe DockingStation do  
  describe '#release_bike' do
    it 'raises an error when there are no bikes available' do
      expect {subject.release_bike}.to raise_error "No bikes available"
    end

    it 'raises an error when there are no working bikes' do
      bike = double(:bike)
      bike.report_broken
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error "All bikes are broken"
    end

    it 'releases working bikes' do

      subject.dock double(:bike)
      bike = subject.release_bike
      expect(bike).to be_working
    end
  end

  describe 'dock' do
    it 'raises an error when full' do
      subject.capacity.times { subject.dock(double(:bike)) }
      expect { subject.dock double(:bike) }.to raise_error "Docking station full"
    end
  end

  it "bike is working" do
    bike1 = double(:bike)
    subject.dock(bike1)
    bike = subject.release_bike
    expect(bike.working?).to eq(true) 
  end

  it { is_expected.to respond_to(:dock).with(1).argument }
  it { is_expected.to respond_to(:bikes) }
  it "docks something" do
    bike = double(:bike)
    expect(subject.dock(bike)).to eq subject.bikes
  end
  it "returns docked bikes" do
    bike = double(:bike)
    subject.dock(bike)
    expect(subject.bikes.pop).to eq bike
  end
  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  describe 'initialization' do
    it 'has a variable capacity' do
      docking_station = DockingStation.new(50)
      50.times { docking_station.dock double(:bike) }
      expect{ docking_station.dock double(:bike) }.to raise_error 'Docking station full'
    end
  end

  # describe 'initialization' do
  #   let(:bike) { double(:bike) }
  #   it 'defaults capacity' do
  #     DockingStation::DEFAULT_CAPACITY.times do
  #       subject.dock(bike)
  #     end
  #     expect{ subject.dock(bike) }.to raise_error 'Docking station full'
  #   end
  # end

end
