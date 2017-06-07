module RecipeHelper
  def like_button(recipe)
    if current_user.liked?(recipe)
      button_to t("unlike"), [:unlike, recipe]
    else
      button_to t("like"), [:like, recipe]
    end
  end
end
