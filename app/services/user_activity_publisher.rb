class UserActivityPublisher
  def initialize(user:, action:, target:)
    @user = user
    @action = action
    @target = target
  end

  def run
    activity = create_activity
    publish_activity(activity)
  end

  private

  attr_reader :user, :target, :action

  def create_activity
    UserActivity.create(
      user: user,
      action: action,
      target: target
    )
  end

  def publish_activity(activity)
    user.followers.find_each do |follower|
      FeedItem.create(user: follower, user_activity: activity)
    end
  end
end
