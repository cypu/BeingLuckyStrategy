require "bls/player"
require "bls/die"

describe Player do
  before(:each) do
    @player = Player.new("John")
  end

  it 'has properly set initialize values' do
    expect(@player.name).to eq("John")
    expect(@player.points).to eq(0)
    expect(@player.can_accumulate).to eq(false)
  end

  it 'is able to accumulate points' do
    @player.can_accumulate = true
    @player.accumulate_points 150
    expect(@player.points).to eq(150)
  end

  it 'is unable to accumulate points' do
    @player.accumulate_points 150
    expect(@player.points).to eq(0)
  end

  it 'is able to throw unscored dice' do
    dice = Array.new(5) {Die.new}
    dice[0].can_be_scoring = true
    dice[0].is_scoring = true
    dice[1].is_scoring = true
    @player.throw_dice dice
    expect(dice[0].value).to eq(nil)
    expect(dice[1].value).to eq(nil)
    expect(dice[2].value).not_to eq(nil)
    expect(dice[3].value).not_to eq(nil)
    expect(dice[4].value).not_to eq(nil)
  end

end
