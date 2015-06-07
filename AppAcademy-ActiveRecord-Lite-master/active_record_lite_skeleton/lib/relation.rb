require_relative 'db_connection'
require 'active_support/inflector'


class Relation
  attr_accessor :klass, :table, :values, :included, :options

  def self.build_from_options(options)
    rel = Relation.new(options.model_name, options.table_name)
    rel.options = options
  end

  def initialize(klass, table, values= {})
    @klass = klass
    @table = table
    @values = values
  end

  def table_name
    table
  end

  def load
    result = DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
      WHERE
        #{self.where_clause}

    SQL
    if included
      build_included_results(result)
    else
      result.map { |r| self.klass.new(r) }
    end
  end



  def dup
    duped = self.class.new(klass, table, values.dup)
    duped.options = self.options if self.options
    duped
  end

  def where(options)
    duped = dup
    dup.values.merge(options)
    dup
  end

  def joins(other)
    @join_clause = "JOIN #{other.table_name}"
  end

  def on_clause(relation)
    @on_clause = "ON "
  end

  def includes(relation)
    dup.inlcuded = relation
    dup
  end

  def build_included_result(results)
    results_hash = included.included_results(results.map(&included.options.primary_key)
    results.map do |r|
      n = klass.new(r)
      n.define_method(inlcuded.options.name) do
        results_hash[r.send(included.options.primary_key)]
      end
    end
  end



  def included_results(keys)
    key_string =  "(#{keys.join(', ')})"
    results = DBConnection.execute(<<-SQL, key_string)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{table_name}.#{options.foreign_key} IN ?

    SQL
    results_hash = Hash.new { |h,k| h[k] = []}
    results.map { |r| included.klass.new(r) }.each do |r|
      results_hash[r.send(options.foreign_key)] << r
    end
    results_hash
  end


  def where_clause
    values.map do |key,value|
      "#{self.table_name}.#{key} = #{value}"
    end.join(" AND ")
  end


end
