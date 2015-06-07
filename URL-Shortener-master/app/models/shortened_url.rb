
class ShortenedUrl < ActiveRecord::Base

  validates :long_url, presence: true,  uniqueness: true, length: { maximum: 1024 }
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true
  validate :less_than_five_urls
  belongs_to :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id


  has_many :visits,
    class_name: 'Visit',
    foreign_key: :shortened_url_id,
    primary_key: :id

  has_many :visitors, through: :visits, source: :visitor

  has_many(
    :uniq_visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
    )

  has_many :taggings,
    class_name: 'Tagging',
    foreign_key: :shortened_url_id,
    primary_key: :id

  has_many :tag_topics, through: :taggings, source: :tag_topic



  def self.random_code
    code = SecureRandom::urlsafe_base64

    if ShortenedUrl.exists?(short_url: code)
       code = self.random_code
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      long_url: long_url,
      short_url: ShortenedUrl.random_code,
      submitter_id: user.id
    )
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    uniq_visitors.count
  end

  def num_recent_uniques
    visits.where(
      "created_at > ?",  10.minutes.ago
    ).select(:visitor_id).distinct.count
  end

  def visit_url(user)
    Visit.record_visit!(user, self)
    Launchy.open(long_url)
  end

  def tag_as(tag)
    tag = TagTopic.fetch_tag(tag)
    Tagging.tag_url(tag, self)
  end

  def less_than_five_urls
    user = User.find_by(id: submitter_id)
    unless user.num_recent_urls(1) <= 5
      self.errors[:submitter_id] << "TOO MANY URLS"
    end
  end
end
