require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET /send_message" do
    it "returns http success" do
      get "/contact/send_message"
      expect(response).to have_http_status(:success)
    end
  end

end
