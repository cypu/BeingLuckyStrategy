require "bls/die"

describe Die do
  before(:each) do
    @die = Die.new()
  end

  it 'has correct value after roll' do
    @die.roll()
    expect(1..6).to cover(@die.value)
    @die.roll(5)
    expect(@die.value).to eq(5)
  end

  it 'is able to set is_scoring' do
    expect(@die.is_scoring).to eq(false)
    @die.is_scoring = true
    expect(@die.is_scoring).to eq(true)
  end

  it 'is able to set can_be_scoring' do
    expect(@die.can_be_scoring).to eq(false)
    @die.can_be_scoring = true
    expect(@die.can_be_scoring).to eq(true)
  end

  it 'is able to reset its state' do
    @die.roll(5)
    @die.is_scoring = true
    @die.can_be_scoring = true
    @die.reset()
    expect(@die.value).to eq(nil)
    expect(@die.is_scoring).to eq(false)
    expect(@die.can_be_scoring).to eq(false)
  end

end
