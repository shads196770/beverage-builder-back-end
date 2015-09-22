# Account seeds.
accounts = [
  { email: 'a@a.com', password: 'a' },
  { email: 'b@b.net', password: 'b' },
  { email: 'c@c.org', password: 'c' }
]

# Ingredient seeds.
ingredients = [
  'Chocolate Liqueur',
  'Coconut Milk',
  'Cream',
  'Dry Vermouth',
  'Gin',
  'Lime Juice',
  'Orange Juice',
  'Pineapple Juice',
  'Simple Syrup',
  'Vodka',
  'White Rum'
]

# Beverage seeds.
beverages = [
  {
    name: 'Alexander',
    ingredients: [
      { name: 'chocolate liqueur', parts: 1 },
      { name: 'gin', parts: 1 },
      { name: 'cream', parts: 1 }
    ]
  },
  {
    name: 'Daiquiri',
    ingredients: [
      { name: 'white rum', parts: 9 },
      { name: 'lime juice', parts: 5 },
      { name: 'simple syrup', parts: 3 }
    ]
  },
  {
    name: 'Martini',
    ingredients: [
      { name: 'gin', parts: 6 },
      { name: 'dry vermouth', parts: 1 }
    ]
  },
  {
    name: 'Piña Colada',
    ingredients: [
      { name: 'white rum', parts: 1 },
      { name: 'coconut milk', parts: 1 },
      { name: 'pineapple juice', parts: 3 }
    ]
  },
  {
    name: 'Screwdriver',
    ingredients: [
      { name: 'vodka', parts: 2 },
      { name: 'orange juice', parts: 1 }
    ]
  }
]

# Models
models = [Account, Beverage, Ingredient]

# Destroy all database records.
# Recipe records are destroyed when their associated beverage record is destroyed.
models.each(&:destroy_all)

# Seed accounts.
accounts.each { |account| Account.create(account) }

# Seed ingredients.
ingredients.each { |ingredient| Ingredient.create(name: ingredient) }

# Seed beverages and recipes.
beverages.each do |beverage|
  next if Beverage.exists?(['lower(name) = ?', beverage[:name].downcase])

  current_beverage = Beverage.create(name: beverage[:name])

  beverage[:ingredients].each do |ingredient|
    recipe = Recipe.new
    recipe.beverage = current_beverage
    recipe.ingredient = Ingredient.find_by('lower(name) = ?', ingredient[:name].downcase)
    recipe.parts = ingredient[:parts]
    recipe.save
  end
end
