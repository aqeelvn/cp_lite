require "rails_helper"

RSpec.describe "Session", :type => :request do
  it "creates a session" do
      user = create(:user)
      access_token = create(:access_token, user: user)

      post "/api/v1/session",
          :params => { :user => {
              :email => user.email,
              :password => user.password_digest
          }}
      expect(response).to have_http_status(:created)
      expect(response.body).to match_json({"access_token": access_token.token})
  end

  it "does not create a session when password is invalid" do
      user = create(:user)
      access_token = create(:access_token, user: user)

      post "/api/v1/session",
          :params => { :user => {
              :email => user.email,
              :password => "invalid"
          }}
      expect(response).to have_http_status(:unauthorized)
  end
end
