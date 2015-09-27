class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :beverage_id, :ingredient_id, :parts
end
