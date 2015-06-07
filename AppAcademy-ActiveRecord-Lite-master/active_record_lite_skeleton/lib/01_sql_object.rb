require_relative 'db_connection'
require 'active_support/inflector'

# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT
        1
    SQL
    cols = columns.first.map(&:to_sym)



    cols
  end

  def self.finalize!


    columns.each do |col|
      define_method(col) do
        attributes[col]
      end
      define_method("#{col}=") do |value|
        attributes[col] = value
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    instance_variable_set('@table_name', table_name)
  end

  def self.table_name
    # ...

    instance_variable_get('@table_name') || (self.to_s.tableize)
  end

  def self.all
    # ...
    objs = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL
    parse_all(objs)

  end

  def self.parse_all(results)
    # ...
    results.map do |result|
      self.new(result)
    end

  end

  def self.find(id)
    # ...
    result = DBConnection.execute(<<-SQL, id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
    SQL
    if result.empty?
      return nil
    else
      return self.new(result.first)
    end
  end

  def initialize(params = {})
    # ...
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name)
      attributes[attr_name] = value
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map { |col| self.send(col) }
  end

  def insert
    # ...
    col_names = self.class.columns.join(',')
    question_marks = ['?']*attribute_values.count
    DBConnection.execute(<<-SQL,*attribute_values)
      INSERT INTO
        #{self.class.table_name}
      VALUES
        ( #{question_marks.join(',')} )

    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    # ...
    cols = self.class.columns
    cols = cols[1..-1].reverse.map { |col| "#{col} = ?"}.join(',')
    DBConnection.execute(<<-SQL,*attribute_values.reverse )
      UPDATE
        #{self.class.table_name}
      SET
        #{cols}
      WHERE
        id = ?
    SQL
  end

  def save
    # ...

    self.id.nil? ? insert : update
  end

end
