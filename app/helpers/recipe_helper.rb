module RecipeHelper
  def bookmark_button(recipe)
    if current_user.bookmarked?(recipe)
      button_to t("remove_bookmark"), [:remove_bookmark, recipe]
    else
      button_to t("bookmark"), [:bookmark, recipe]
    end
  end

  def like_button(recipe)
    if current_user.liked?(recipe)
      button_to t("unlike"), [:unlike, recipe]
    else
      button_to t("like"), [:like, recipe]
    end
  end
end
