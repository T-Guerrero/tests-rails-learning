require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /weapons" do
    it "return success status" do
      get weapons_path
      expect(response).to have_http_status(200)
    end

    before do
      @weapon = create(:weapon)
      get weapons_path
    end

    it "the weapon's name is present" do
      expect(response.body).to include(@weapon.name)
    end

    it "the weapon's current power is present" do
      expect(response.body).to include(@weapon.current_power.to_s)
    end

    it "the weapon's title is present" do
      expect(response.body).to include(@weapon.title)
    end

    it "the weapon's show link is present" do
      expect(response.body).to include("Show")
    end
  end

  describe "GET /weapons/:id" do
    it "all  weapon's attributes are present" do
      weapon = create(:weapon)
      get "/weapons/#{weapon.id}"
      expect(response.body).to include(weapon.title)
      expect(response.body).to include(weapon.description)
      expect(response.body).to include(weapon.level.to_s)
      expect(response.body).to include(weapon.power_base.to_s)
      expect(response.body).to include(weapon.power_step.to_s)
    end
  end

  describe "POST /weapons" do
    it "should create the weapon if used valid attributes" do
      weapon_attributes = attributes_for(:weapon)
      post weapons_path, params: { weapon: weapon_attributes }
      expect(Weapon.last).to have_attributes(weapon_attributes)  
    end

    it "should not create the weapon if used invalid attributes" do
      weapon_attributes = {
        name: ''
      }
      expect{ post weapons_path, params: { weapon: weapon_attributes } }.to_not change(Weapon, :count)  
    end
  end

  describe "DELETE /weapons/:id" do
    it "should remove the correct weapon" do
      weapon = create(:weapon)
      delete "/weapons/#{weapon.id}"
      expect(Weapon.all).to_not include(weapon)  
    end
  end
end