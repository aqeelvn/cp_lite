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
    @recipe = Recipe.new
  end

  def create
    recipe = current_user.recipes.create(recipe_params)
    redirect_to recipe
  end

  def update
    recipe = find_recipe
    recipe.update_attributes(recipe_params)
    redirect_to recipe
  end

  private

  def find_recipe
    current_user.recipes.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description)
  end
end
