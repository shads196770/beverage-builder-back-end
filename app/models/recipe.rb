class Recipe < ActiveRecord::Base
  belongs_to :beverage, inverse_of: :recipes
  belongs_to :ingredient, inverse_of: :recipes

  def self.update_recipe(beverage_id, recipe)
    db_records = Beverage.find(beverage_id).recipes
    vm_records = recipe

    if db_records.length < vm_records.length
      db_less_than_vm(db_records, vm_records)
    elsif db_records.length > vm_records.length
      db_greater_than_vm(db_records, vm_records)
    else
      db_equals_vm(db_records, vm_records)
    end
  end

  def self.db_equals_vm(db_records, vm_records)
    db_records.zip(vm_records).each do |db_record, vm_record|
      db_record.update(vm_record)
    end
  end

  def self.db_greater_than_vm(db_records, vm_records)
    vm_records.zip(db_records).each do |vm_record, db_record|
      db_record.update(vm_record)
    end

    db_records.slice(vm_records.length, db_records.length).each(&:delete)
  end

  def self.db_less_than_vm(db_records, vm_records)
    db_records.zip(vm_records).each do |db_record, vm_record|
      db_record.update(vm_record)
    end

    vm_records.slice(db_records.length, vm_records.length).each { |record| Recipe.create(record) }
  end
end
