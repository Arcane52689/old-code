# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#


class Question < ActiveRecord::Base

  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses, through: :answer_choices, source: :responses

  def results
    result_hash = {}
    answer = self.answer_choices
      .select('answer_choices.* , COUNT(responses.user_id) AS total')
      .joins("LEFT JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .group('answer_choices.id')
    answer.map { |each| result_hash[each.text] = each.total }
    result_hash
  end


end
