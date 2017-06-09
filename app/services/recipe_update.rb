class RecipeUpdate
  def initialize(recipe:, recipe_params:)
    @recipe = recipe
    @recipe_params = recipe_params
  end

  def run
    recipe.update(recipe_params).tap do |success|
      if success
        build_search_index
      end
    end
  end

  private

  attr_reader :recipe, :recipe_params

  def build_search_index
    RecipeIndexer.new(recipe).run
  end
end
