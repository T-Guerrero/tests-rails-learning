require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "GET /enemies" do
    it 'returns status code 200' do
      get enemies_path  
      expect(response).to have_http_status(200)  
    end

    it "returns all the enemies" do
      enemies = create_list(:enemy, 3)
      get enemies_path
      enemies.each_with_index do |enemy, index|
        expect(enemy).to have_attributes(json[index].except('created_at', 'updated_at'))  
      end
    end
  end

  describe "PUT /enemies" do
    context "when the enemy exists" do
      let(:enemy) { create(:enemy) }
      let(:updated_attributes) { attributes_for(:enemy) }

      before do
        put "/enemies/#{enemy.id}", params: updated_attributes
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)  
      end

      it "updates the record" do
        expect(enemy.reload).to have_attributes(updated_attributes)
      end
      
      it "return the enemy updated" do
        #'json' is defined in support/request_helper.rb
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
      end
    end

    context "when the enemy does not exist" do
      before do
        put '/enemies/0', params: attributes_for(:enemy)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)  
      end
      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "DELETE /enemies/:id" do
    context "when the enemy exists" do
      let(:enemy) { create(:enemy) }

      before do
        delete "/enemies/#{enemy.id}"
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)  
      end
      
      it "destroy the record successfully" do
        expect{ Enemy.find(enemy.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
    context "when the enemy does not exist" do
      before do
        delete '/enemies/0'
      end
      it "returns status code 404" do
        expect(response).to have_http_status(404)  
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)  
      end
    end
  end

  describe "GET /enemies/:id" do
    context "when the enemy exists" do
      let(:enemy) { create(:enemy) }
      before do
        get "/enemies/#{enemy.id}"   
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)  
      end

      it "returns the enemy" do
        expect(enemy).to have_attributes(json.except('created_at', 'updated_at'))  
      end
    end

    context "when the enemy does not exist" do
      before do
        get '/enemies/0'
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)  
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "POST /enemies" do
    context "when used valid attributes" do
      let(:enemy_attributes) { attributes_for(:enemy) }
      
      before do
        post '/enemies/', params: enemy_attributes
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)  
      end
      
      it "create the record" do
        expect(Enemy.first).to have_attributes(enemy_attributes)  
      end
    end

    context "when used invalid attributes" do
      before do
        post '/enemies/', params: ''  
      end

      it "return status 422" do
        expect(response).to have_http_status(422)  
      end

      it "does not create the enemy" do
        expect(json['errors']).to_not be_nil 
      end
    end
  end
end
