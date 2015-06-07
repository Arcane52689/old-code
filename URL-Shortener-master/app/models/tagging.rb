class Tagging < ActiveRecord::Base
  validates :tag_id, presence: true
  validates :shortened_url_id, presence: true

  def self.tag_url(tag, shortened_url)
    Tagging.create!(tag_id: tag.id, shortened_url_id: shortened_url.id)
  end

  belongs_to :tag_topic,
    class_name: "TagTopic",
    foreign_key: :tag_id,
    primary_key: :id

  belongs_to :shortened_url,
    class_name: "ShortenedUrl",
    foreign_key: :shortened_url_id,
    primary_key: :id

end
