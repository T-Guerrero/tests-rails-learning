class WeaponsController < ApplicationController
  def index
    @weapons = Weapon.all
  end

  def create
    @weapon = Weapon.create(weapon_params)
    redirect_to weapons_path
  end

  def destroy
    weapon = Weapon.find_by(id: params[:id])
    if (weapon)
      weapon.destroy
    end
    redirect_to weapons_path
  end

  def show
    @weapon = Weapon.find_by(id: params[:id])
  end

  private
  def weapon_params
    params.require(:weapon).permit(:name, :description, :power_base, :power_step)
  end
end
