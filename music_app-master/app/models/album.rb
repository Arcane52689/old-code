# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer
#  live       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class Album < ActiveRecord::Base

  validates :band_id, :name, presence: true


  belongs_to :band

  has_many :tracks

  def live?
    self.live
  end

  def live_or_studio
    live? ? "live" : "in studio"
  end
end
