class IngredientSerializer < ActiveModel::Serializer
  attributes :name

  has_many :beverages, through: :recipes

  def beverages
    object.beverages.map(&:name)
  end
end
