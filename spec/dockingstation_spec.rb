require "docking_station"
require "bike"

describe DockingStation do
  let(:bike) {subject.release_bike}
  
  it {is_expected.to respond_to :release_bike}
  it {expect(bike).to be_working}
end