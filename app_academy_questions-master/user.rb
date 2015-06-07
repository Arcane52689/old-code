class User
  extend FindBy
  include Save

  def self.table_name
    'users'
  end


  def self.find_by_name(fname, lname)
    find_result = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    self.new(find_result.first)
  end

  attr_accessor :fname, :lname, :id

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end


  def save
    self.id.nil? ? create : update
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_author_id(self.id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(self.id)
  end

  def average_karma
    result = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        CAST(COUNT(question_likes.user_id) AS FLOAT) / COUNT(DISTINCT(user_questions.id))
      FROM
        (
          SELECT
            id AS id
          FROM
            questions
          where
            user_id = ?
        ) AS user_questions
      LEFT JOIN
        question_likes
      ON
        user_questions.id = question_likes.question_id
    SQL

    result.first.values.first
  end

end
