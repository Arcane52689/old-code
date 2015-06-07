# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#


class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id

  has_many :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id


  def completed_polls
    polls = active_polls.having('COUNT(questions.poll_id) = COUNT(sub.user_id)')

    polls.map { |poll| poll }
  end

  def uncompleted_polls
    polls = active_polls.having('COUNT(sub.user_id) BETWEEN 1 AND COUNT(questions.poll_id) - 1')

    polls.map { |poll| poll }
  end

  def active_polls

    subquery = <<-SQL
      SELECT responses.*,
        answer_choices.question_id AS q_id
      FROM
        responses
      JOIN
        answer_choices
      ON
        responses.answer_choice_id = answer_choices.id
      WHERE
        responses.user_id = #{self.id}
    SQL

    polls = Poll.select('polls.*')
      .joins(:questions)
      .joins("LEFT JOIN (#{subquery}) AS sub ON questions.id = sub.q_id")
      .group('polls.id')
    polls
  end
end
