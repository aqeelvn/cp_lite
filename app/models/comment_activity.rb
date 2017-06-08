class CommentActivity < UserActivity
  delegate :title, to: :recipe, prefix: true
  delegate :text, to: :comment

  def comment
    target
  end

  def recipe
    comment.recipe
  end
end
