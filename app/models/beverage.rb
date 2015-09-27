class Beverage < ActiveRecord::Base
  has_many :recipes, inverse_of: :beverage, dependent: :destroy
  has_many :ingredients, through: :recipes

  validates :name, presence: true, uniqueness: true
end
