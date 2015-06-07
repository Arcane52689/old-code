class Sub < ActiveRecord::Base

  validates :title, :user_id, presence:true
  validates :title, uniqueness: true

  belongs_to :moderator,
    class_name: "User"

  has_many :post_subs,
    dependent: :destroy

  has_many :posts,
    through: :post_subs,
    source: :post

end
