class RecipeCommenting
  def initialize(user:, recipe:, text:)
    @user = user
    @recipe = recipe
    @text = text
  end

  def run
    comment = create_comment

    if comment.persisted?
      publish_activity(comment)
    end
  end

  private

  attr_reader :user, :recipe, :text

  def create_comment
    recipe.comments.create({:user => user, :text => text})
  end

  def publish_activity(comment)
    UserActivityPublisher.new(user:user, target: comment, action: "comment").run
  end
end
