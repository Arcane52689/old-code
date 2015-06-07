require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # ...

    define_method(name) do
      through = self.class.assoc_options[through_name]
      source = through.model_class.assoc_options[source_name]

      on_clause = "#{through.table_name}.#{source.foreign_key} = #{source.table_name}.#{source.primary_key}"
      where_clause = "#{through.table_name}.#{through.primary_key} = ? "
      result = DBConnection.execute(<<-SQL, self.send(through.foreign_key))
        SELECT
          #{source.table_name}.*
        FROM
          #{through.table_name}
        JOIN
          #{source.table_name}
        ON
          #{on_clause}
        WHERE
          #{where_clause}

      SQL
      result.map { |r| source.model_class.new(r)}.first
    end
  end
end
