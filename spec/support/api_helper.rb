require "rails_helper"

module ApiHelper
  def api_post(path, params:nil, user:nil)
    headers = {}

    if user.present?
      headers = { "X-Access-Token": user.access_token.token }
    end
    post "/api/v1#{path}", params: params, headers: headers
  end
end

RSpec.configure do |config|
  config.include ApiHelper
end

RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    expected.with_indifferent_access <= JSON.parse(actual).with_indifferent_access
  end
end
