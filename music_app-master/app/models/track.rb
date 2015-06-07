# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string
#  album_id   :integer
#  bonus      :boolean
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  belongs_to :album
  has_one :band, through: :album, source: :band

  validates :name, :album_id, presence: true

  has_many :notes

  def bonus?
    bonus
  end

  def track_type
    bonus? ? "Bonus Track!" : "regular track"
  end
end
