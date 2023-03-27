require 'rails_helper'


RSpec.describe "Articles", type: :request do
  describe "GET / index receives articles" do

    it "returns a successful response" do
      expect(response).to be_successful
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end


  end
end
