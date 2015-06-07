class TagTopic < ActiveRecord::Base

  validates :tag, presence: true, uniqueness: true

  has_many :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_id,
    primary_key: :id

  has_many :shortened_urls, through: :taggings, source: :shortened_url

  def self.fetch_tag(tag)
    self.find_by(tag: tag) || self.create!(tag: tag)
  end

end
