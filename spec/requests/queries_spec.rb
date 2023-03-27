require 'rails_helper'

RSpec.describe "Queries", type: :request do
  describe "GET /index" do
    it 'successfull response ' do
      expect(response).to be_successful
    end
  end
end
