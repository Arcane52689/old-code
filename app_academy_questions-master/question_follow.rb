class QuestionFollow

  def self.followers_for_question_id(question_id)

    results = QuestionsDatabase.instance.execute( <<-SQL, question_id)

      SELECT
        users.*
      FROM
        question_follows
      JOIN
        users ON question_follows.user_id = users.id
      WHERE
        question_id = ?
    SQL

    results.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)

    results = QuestionsDatabase.instance.execute( <<-SQL, user_id)

      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON question_follows.user_id = questions.user_id
      WHERE
        question_follows.user_id = ?
    SQL

    results.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        q.*
      FROM (
        SELECT
          questions.id AS id
        FROM
          questions
        JOIN
          question_follows
        ON
          question_follows.question_id = questions.id
        GROUP BY
          questions.id
        ORDER BY
          COUNT(*) DESC
        LIMIT
          ?
      ) AS r
      JOIN
        questions AS q
      ON
        q.id = r.id
    SQL

    results.map { |r| Question.new(r) }
  end

  attr_accessor :question_id, :user_id

  def initialize(options = {} )
    @question_id = options['question_id']
    @user_id = options['user_id']
  end


  def create

    QuestionsDatabase.instance.execute( <<-SQL, question_id, user_id)
      INSERT INTO
        question_follows(question_id, user_id)
      VALUES
        (?, ?)
    SQL
  end

end
