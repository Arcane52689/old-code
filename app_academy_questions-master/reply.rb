class Reply

  extend FindBy
  include Save

  def self.table_name
    'replies'
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    results.map { |result| self.new(result) }

  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    results.map { |result| self.new(result) }

  end

  attr_accessor :id, :user_id, :question_id, :body, :reply_id

  def initialize( options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @body = options['body']
    @reply_id = options['reply_id']
  end

  def parent_reply
    Reply.find_by_id(self.reply_id)
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply_id = ?
    SQL

    results.map { |r| Reply.new(r) }
  end
end
