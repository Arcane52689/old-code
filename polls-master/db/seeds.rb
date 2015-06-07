# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




10.times do |i|
  User.create!(user_name: "user#{i}")
end

SAMPLE_Q = ['who', 'what', 'where', 'why', 'when']
SAMPLE_A = ['me', 'your face', 'your mom', 'i said so', 'last night']
5.times do |i|
  User.all.sample.authored_polls.create!(title: "poll#{i}")
end

Poll.all.each do |poll|
  2.times do
    poll.questions.create!(text: SAMPLE_Q.sample)
  end
end


Question.all.each do |q|
  2.times do
    q.answer_choices.create!(text: SAMPLE_A.sample)
  end
end

Poll.first.questions.each do |question|
  Response.create!(
    user_id: User.first.id,
    answer_choice_id: question.answer_choices.sample.id
  )
end
