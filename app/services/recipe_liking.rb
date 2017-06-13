class RecipeLiking
  def initialize(user:, recipe:)
    @user = user
    @recipe = recipe
  end

  def run
    create_like.tap do |like|
      if like.persisted?
        publish_activity
      end
    end
  end

  private

  attr_reader :user, :recipe

  def create_like
    user.like(recipe)
  end

  def publish_activity
    UserActivityPublisher.new(user:user, target: recipe, action: "like").run
  end
end
