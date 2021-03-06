require "rails_helper"

module ApiHelper
  def api_request(method, path, params:nil, user:nil)
    headers = {}

    if user.present?
      headers = { "X-Access-Token": user.access_token.token }
    end
    method.call("/api/v1#{path}", params: params, headers: headers)
  end

  def api_post(path, params:nil, user:nil)
    api_request(method(:post), path, params: params, user: user)
  end

  def api_get(path, params:nil, user:nil)
    api_request(method(:get), path, params: params, user: user)
  end

  def api_patch(path, params:nil, user:nil)
    api_request(method(:patch), path, params: params, user: user)
  end

  def api_delete(path, params:nil, user:nil)
    api_request(method(:delete), path, params: params, user: user)
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
