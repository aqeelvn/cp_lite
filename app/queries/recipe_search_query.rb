class RecipeSearchQuery
  def initialize(query:)
    @query = query
  end

  def to_relation
    Recipe.
      joins(:search_index).
      where("`search_indices`.`index` LIKE ?", query_string)
  end

  private

  attr_reader :query

  def query_string
    "%#{query}%"
  end
end
