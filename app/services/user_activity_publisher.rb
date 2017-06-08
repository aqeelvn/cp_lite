class UserActivityPublisher
  def initialize(user:, action:, target:)
    @user = user
    @action = action
    @target = target
  end

  def run
    return if user.followers.none?

    activity = get_activity

    if activity.new_record?
      begin
        activity.save
      rescue ActiveRecord::RecordNotUnique
        return
      end

      publish_activity(activity)
    end
  end

  private

  ACTIVITY_MAP = {
    bookmark: BookmarkActivity,
    like: LikeActivity,
    comment: CommentActivity
  }.freeze

  private_constant :ACTIVITY_MAP

  attr_reader :user, :target, :action

  def activity_class
    ACTIVITY_MAP.fetch(action.to_sym)
  end

  def get_activity
    activity_class.find_or_initialize_by(
      user: user,
      target: target
    )
  end

  def publish_activity(activity)
    user.followers.find_each do |follower|
      FeedItem.create(user: follower, user_activity: activity)
    end
  end
end
