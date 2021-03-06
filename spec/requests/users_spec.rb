require "rails_helper"

RSpec.describe "User", :type => :request do
  it "creates a user" do
      api_post "/users",
          :params => { :user => {
              :username => "test",
              :email => "test@example.com",
              :password => "testpassword"
          }}
      expect(response).to have_http_status(:created)

      expect(response.body).to match_json({"username": "test", "email": "test@example.com"})
  end

  it "fails to create user without username" do
      api_post "/users",
          :params => { :user => {
              :email => "test@example.com",
              :password => "testpassword"
          }}
      expect(response).to have_http_status(:unprocessable_entity)
  end
end
