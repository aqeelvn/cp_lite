FactoryGirl.define do
  factory :recipe do
    user nil
    title "MyString"
    description "MyString"

    transient do
      steps_count 5
      ingredients_count 5
    end

    after :build do |recipe, evaluator|
      recipe.steps << build_list(:step, evaluator.steps_count)
      recipe.ingredients << build_list(:ingredient, evaluator.ingredients_count)
    end
  end
end
