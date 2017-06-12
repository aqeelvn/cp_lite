class PublishActivityJob < ApplicationJob
  queue_as :default

  def perform(user:, action:, target:)
    UserActivityPublisher.new(user: user, action: action, target: target).run(delay: false)
  end
end
