require "docking_station"
require "bike"

describe DockingStation do
  let(:bike) {DockingStation.new.release_bike}
  
  it { is_expected.to respond_to :release_bike }
  it { expect(bike).to be_working }
  it { is_expected.to respond_to(:dock).with(1).argument }
end