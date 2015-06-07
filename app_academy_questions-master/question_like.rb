class QuestionLike

  attr_accessor :question_id, :user_id

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute( <<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users
      ON
        users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?


    SQL

    results.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute( <<-SQL, question_id)
      SELECT
        COUNT(user_id)
      FROM
        question_likes
      WHERE
        question_id = ?
      GROUP BY
        question_id


    SQL

    result.first.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute( <<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions
      ON
        questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?
    SQL

    results.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM (
        SELECT
          question_id AS id
        FROM
          question_likes
        GROUP BY
          question_id
        ORDER BY
          COUNT(user_id) DESC
        LIMIT ?
      ) as liked
      JOIN
        questions
      ON
        questions.id = liked.id

    SQL

    results.map { |r| Question.new(r) }
  end

  def initialize(options = {} )
    @question_id = options['question_id']
    @user_id = options['user_id']
  end


  def create

    QuestionsDatabase.instance.execute( <<-SQL, question_id, user_id)
      INSERT INTO
        question_likes(question_id, user_id)
      VALUES
        (?, ?)
    SQL
  end

end
