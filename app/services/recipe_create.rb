class RecipeCreate
  def initialize(user:, recipe_params:)
    @user = user
    @recipe_params = recipe_params
  end

  def run
    recipe = create_recipe

    if recipe.persisted?
      publish_activity(recipe)
      build_search_index(recipe)
    end

    recipe
  end

  private

  attr_reader :user, :recipe_params

  def create_recipe
    user.recipes.create(recipe_params)
  end

  def publish_activity(recipe)
    UserActivityPublisher.new(user:user, target: recipe, action: "recipe_publish").run
  end

  def build_search_index(recipe)
    RecipeIndexer.new(recipe).run
  end
end
