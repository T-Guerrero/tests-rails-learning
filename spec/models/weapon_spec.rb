require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it "return the correct weapon title" do
    weapon = create(:weapon)
    expect(weapon.title).to match(/#{weapon.name} ##{weapon.level}/)  
  end

  it "return the correct weapon current power" do
    weapon = create(:weapon)
    expect(weapon.current_power).to be(weapon.power_base + ((weapon.level - 1) * weapon.power_step))
  end

  it "the default level value is 1 when a new weapon is created" do
    weapon = create(:weapon)
    expect(weapon.level).to be(1)  
  end
end
