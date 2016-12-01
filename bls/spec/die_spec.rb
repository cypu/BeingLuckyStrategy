require "bls/die"

describe Die do
  before(:each) do
    @die = Die.new()
  end

  it 'has correct value after roll' do
    @die.roll()
    expect(1..6).to cover(@die.value)
  end

  it 'is able to set scoring' do
    expect(@die.is_scoring).to eq(false)
    @die.is_scoring = true
    expect(@die.is_scoring).to eq(true)
  end
end
