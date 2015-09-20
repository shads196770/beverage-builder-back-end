class Ingredient < ActiveRecord::Base
  has_many :recipes, inverse_of: :ingredient
  has_many :beverages, through: :recipes
end
