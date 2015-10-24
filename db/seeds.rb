# Account seeds.
accounts = [
  { email: 'c@c.com', password: 'c' },
  { email: 'g@g.gov', password: 'g' },
  { email: 'e@e.edu', password: 'e' },
  { email: 'm@m.mil', password: 'm' },
  { email: 'n@n.net', password: 'n' },
  { email: 'o@o.org', password: 'o' }
]

# Ingredient seeds.
ingredients = [
  'Angosutra Bitters',
  'Black Tea',
  'Bourbon',
  'Canadian Whisky',
  'Chocolate Liqueur',
  'Coconut Milk',
  'Coffee',
  'Coffee Liqueur',
  'Cream',
  'Dry Vermouth',
  'Fresh Cream',
  'Gin',
  'Ginger Ale',
  'Ginger Beer',
  'Green Tea',
  'Irish Cream',
  'Lime Juice',
  'Milk',
  'Orange Juice',
  'Pineapple Juice',
  'Rum',
  'Scotch',
  'Simple Syrup',
  'Sweet Red Vermouth',
  'Sweetened Condensed Milk',
  'Vodka',
  'Water',
  'Whiskey',
  'White Rum',
  'White Tea'
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
    name: 'Black Russian',
    ingredients: [
      { name: 'vodka', parts: 5 },
      { name: 'coffee liqueur', parts: 2 }
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
    name: 'Hong Kong-Style Milk Tea',
    ingredients: [
      { name: 'black tea', parts: 5 },
      { name: 'sweetened condensed milk', parts: 2 }
    ]
  },
  {
    name: 'Manhattan',
    ingredients: [
      { name: 'canadian whisky', parts: 5 },
      { name: 'sweet red vermouth', parts: 2 }
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
    name: 'Moscow Mule',
    ingredients: [
      { name: 'vodka', parts: 9 },
      { name: 'lime juice', parts: 1 },
      { name: 'ginger beer', parts: 24 }
    ]
  },
  {
    name: 'Old Fashioned',
    ingredients: [
      { name: 'bourbon', parts: 9 },
      { name: 'angosutra bitters', parts: 4 }
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
  },
  {
    name: 'White Russian',
    ingredients: [
      { name: 'vodka', parts: 5 },
      { name: 'coffee liqueur', parts: 2 },
      { name: 'fresh cream', parts: 3 }
    ]
  },
  {
    name: 'Yuanyang',
    ingredients: [
      { name: 'coffee', parts: 3 },
      { name: 'black tea', parts: 5 },
      { name: 'sweetened condensed milk', parts: 2 }
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
