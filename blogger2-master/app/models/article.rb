class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings

  has_many :tags, through: :taggings, source: :tag

  def tag_list
    self.tags.map do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").map { |s| s.strip.downcase}.uniq
    self.tags tag_names.map do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
    end
  end



end
