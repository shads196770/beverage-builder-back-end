class Beverage < ActiveRecord::Base
  has_many :recipes, dependent: :destroy
  has_many :ingredients, through: :recipes
end
