class Enemy < ApplicationRecord
  enum kind: [ :goblin, :orc, :demon, :dragon ]

  validates :level, numericality: { greater_than: 0, less_than_or_equal_to: 99 }
  validates :name, :power_base, :power_step, :level, :kind, presence: true

  def current_power
    power_base + ((level - 1) * power_step)
  end
end
