class Search
  def initialize(query:)
    @query = query
  end

  def run
    RecipeSearchQuery.new(query: query).to_relation
  end

  private

  attr_reader :query
end
