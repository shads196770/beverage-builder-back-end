class Ingredient < ActiveRecord::Base
  has_many :recipes
  has_many :beverages, through: :recipes
end
