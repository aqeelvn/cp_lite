require "rails_helper"

RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    expected.with_indifferent_access <= JSON.parse(actual).with_indifferent_access
  end
end
