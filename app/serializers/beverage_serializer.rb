class BeverageSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :recipes, root: :recipe

  def recipes
    object.recipes.map { |i| { id: i.ingredient.id, name: i.ingredient.name, parts: i.parts } }
  end
end
