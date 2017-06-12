class UserActivityPublisher
  def initialize(user:, action:, target:)
    @user = user
    @action = action
    @target = target
  end

  def run(delay: true)
    return if user.followers.none?

    if delay
      run_delayed_job
    else
      run_publish_activity
    end
  end

  private

  ACTIVITY_MAP = {
    bookmark: BookmarkActivity,
    like: LikeActivity,
    comment: CommentActivity,
    recipe_publish: RecipePublishActivity
  }.freeze

  private_constant :ACTIVITY_MAP

  attr_reader :user, :target, :action

  def run_delayed_job
    PublishActivityJob.perform_later(user: user, action: action, target: target)
  end

  def run_publish_activity
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
