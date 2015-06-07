require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...
    search_clause = params.keys.map { |k| "#{k} = ?"}.join(" AND ")
    vals = params.values
    result = DBConnection.execute(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{search_clause}
    SQL
    parse_all(result)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
