require 'rails_helper'

RSpec.describe "Projects", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/project/show"
      expect(response).to have_http_status(:success)
    end
  end

end
