class BeverageSerializer < ActiveModel::Serializer
  attributes :name

  has_many :recipes, root: :recipe

  def recipes
    object.recipes.map { |i| { name: i.ingredient.name, parts: i.parts } }
  end
end
