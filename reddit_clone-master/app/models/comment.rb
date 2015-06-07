class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author,
    class_name: 'User',
    foreign_key: :user_id

  has_many :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    dependent: :destroy


  validates :post_id, :user_id, :content, presence: true



end
