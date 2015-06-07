
module Save

  def save
    self.id.nil? ? create : update
  end

  def create
    columns = column_names
    values_string = columns.map { |v| "?" }.join(", ")
    query_columns = columns.join(", ")

    QuestionsDatabase.instance.execute(<<-SQL, *get_values(columns))
      INSERT INTO
        #{self.class.table_name}(#{query_columns})
      VALUES
        (#{values_string})
    SQL

    self.id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    columns = column_names
    query_columns = columns.map { |v| "#{v} = ?" }.join(", ")

    QuestionsDatabase.instance.execute(<<-SQL, *get_values(columns))
      UPDATE
        #{self.class.table_name}
      SET
        #{query_columns}
      WHERE
        id = #{self.id}
    SQL
  end

  def column_names
    vars = self.instance_variables.map(&:to_s).drop(1)
    vars.map { |v| v.delete("@") }
  end

  def get_values(columns)
    columns.map { |c| send(c) }
  end
end
