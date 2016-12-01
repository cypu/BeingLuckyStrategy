require "bls/player"

describe Player do
  before(:each) do
    @player = Player.new("John")
  end

  it 'has properly set initialize values' do
    expect(@player.name).to eq("John")
    expect(@player.points).to eq(0)
    expect(@player.can_accumulate).to eq(false)
  end

  it 'is able to accumulate after get 300 points' do
    @player.accumulate_points(100)
    expect(@player.points).to eq(0)
    @player.accumulate_points(300)
    expect(@player.points).to eq(300)
    @player.accumulate_points(300)
    expect(@player.points).to eq(600)
    expect(@player.can_accumulate).to eq(true)
  end
end
