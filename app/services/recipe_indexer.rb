class RecipeIndexer
  def initialize(recipe)
    @recipe = recipe
  end

  def run
    search_index = SearchIndex.find_or_initialize_by(recipe: recipe)
    search_index.index = recipe_index
    search_index.save
  end

  private

  attr_reader :recipe

  def recipe_index
    (recipe_values + ingredient_values).join(" ")
  end

  def recipe_values
    [recipe.title]
  end

  def ingredient_values
    recipe.ingredients.map(&:name)
  end
  #Recipe.find_each { |recipe| RecipeIndexer.new(recipe).run }
end
