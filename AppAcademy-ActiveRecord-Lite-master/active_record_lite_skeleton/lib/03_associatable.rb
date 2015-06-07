require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    class_name.constantize
  end

  def table_name
    # ...
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...

    self.class_name = name.to_s.camelcase
    self.foreign_key = (name.to_s+"_id").to_sym
    self.primary_key = :id

    options.each do |key,value|
      instance_variable_set("@#{key}", value)
    end



  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})

    self.class_name = name.to_s.singularize.camelcase
    self.foreign_key = (self_class_name.downcase + "_id").to_sym
    self.primary_key = :id


    options.each do |key,value|
      instance_variable_set("@#{key}", value)
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    b = BelongsToOptions.new(name, options)

    define_method(name) do
      b.model_class.where(b.primary_key => self.send(b.foreign_key)).first
    end
    assoc_options[name] = b
  end

  def has_many(name, options = {})
    # ...
    h = HasManyOptions.new(name,self.to_s, options)
    define_method(name) do
      h.model_class.where(h.foreign_key => send(h.primary_key) )
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @options ||= {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
