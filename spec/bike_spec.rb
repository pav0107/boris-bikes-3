require "bike"

describe Bike do
  it {is_expected.to respond_to :working?}

  it 'can be reported as broken' do
    subject.report_broken
    expect(subject.broken?).to eq true
  end
end