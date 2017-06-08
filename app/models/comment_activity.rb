class CommentActivity < UserActivity
  delegate :title, to: :recipe, prefix: true
  delegate :text, to: :comment
  delegate :recipe, to: :comment

  def comment
    target
  end
end
