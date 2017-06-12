class PublishActivityJob < ApplicationJob
  queue_as :default
  rescue_from 'ActiveJob::DeserializationError', with: ->{}

  def perform(user:, action:, target:)
    UserActivityPublisher.
      new(user: user, action: action, target: target).
      run(delay: false)
  end
end
