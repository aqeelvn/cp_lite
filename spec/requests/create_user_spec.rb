require "rails_helper"

RSpec.describe "Create user", :type => :request do
  it "creates a user" do
      post "/api/v1/users",
          :params => { :user => {
              :username => "test",
              :email => "test@example.com",
              :password => "testpassword"
          }}
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:created)

      parsed_body = JSON.parse(response.body)
      expect(parsed_body["username"]).to eq("test")
      expect(parsed_body["email"]).to eq("test@example.com")
  end
end
