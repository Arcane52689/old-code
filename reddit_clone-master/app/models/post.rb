class Post < ActiveRecord::Base

  validates :title, :author_id, presence: true
  validate :has_sub_ids

  before_save :valid_url

  belongs_to :author, class_name: "User"

  has_many :post_subs,
    dependent: :destroy,
    inverse_of: :post

  has_many :subs, through: :post_subs, source: :sub
  has_many :comments


  def valid_url
    unless self.url[0..6] == 'http://' || self.url == ""
      self.url.insert(0,"http://")
    end
  end

  def has_sub_ids
    if sub_ids.none?
      errors[:subs] << "Must have at least  one sub selected"
    end
  end

  def comments_by_parent_id
    result = Hash.new { |h, k| h[k] = [] }
    all_comments = comments.includes(:author)
    all_comments.each do |comment|
      if comment.parent_comment_id.nil?
        result[:parent_comment] << comment
      else
        result[comment.parent_comment_id] << comment
      end
    end

    result
  end


end
