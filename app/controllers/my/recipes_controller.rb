class My::RecipesController < My::BaseController

  def edit
    @recipe = find_recipe
  end

  def destroy
    recipe = find_recipe
    recipe.destroy
    redirect_to root_path
  end

  def new
    @recipe = Recipe.new(ingredients:[Ingredient.new], steps:[Step.new])
  end

  def create
    @recipe = RecipeCreate.new(user: current_user, recipe_params: recipe_params).run

    if @recipe.persisted?
      redirect_to @recipe
    else
      render :edit
    end
  end

  def update
    recipe = find_recipe
    RecipeUpdate.new(recipe: recipe, recipe_params: recipe_params).run
    redirect_to recipe
  end

  private

  def find_recipe
    current_user.recipes.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).
    permit(
      :title,
      :description,
      :cover_image,
      ingredients_attributes: [:name, :id, :_destroy],
      steps_attributes: [:description, :id, :_destroy]
    )
  end
end
