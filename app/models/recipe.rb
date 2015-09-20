class Recipe < ActiveRecord::Base
  belongs_to :beverage, inverse_of: :recipes
  belongs_to :ingredient, inverse_of: :recipes
end
