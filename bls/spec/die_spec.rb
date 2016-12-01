require "bls/die"

describe Die do
  it 'has correct value after roll' do
    die = Die.new()
    die.roll()
    expect(1..6).to cover(die.value)
  end

  it 'is able to set scoring' do
    die = Die.new()
    expect(die.is_scoring).to eq(false)
    die.is_scoring = true
    expect(die.is_scoring).to eq(true)
  end
end
