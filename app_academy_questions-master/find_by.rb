module FindBy
  def find_by_id(id)
    find_result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    return nil if find_result.empty?
    self.new(find_result.first)
  end
end
