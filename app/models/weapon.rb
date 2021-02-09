class Weapon < ApplicationRecord

validates :name, :description, :power_base, :power_step, presence: true

  def title
    "#{self.name} ##{self.level}"
  end

  def current_power
    self.power_base + ((self.level - 1) * self.power_step)
  end
end
