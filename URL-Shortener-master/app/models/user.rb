
class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    class_name: 'ShortenedUrl',
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits,
    class_name: 'Visit',
    foreign_key: :visitor_id,
    primary_key: :id

  has_many :visited_urls, through: :visits, source: :visited_url

  has_many(
    :uniq_visited_urls,
    Proc.new { distinct },
    through: :visits,
    source: :visited_url
    )

  def self.fetch_user(email)
    self.find_by(email: email) || self.create!(email: email)
  end

  def num_recent_urls(time)
    submitted_urls.where(
      "created_at > ?", time.minutes.ago
    ).count
  end
end
