class Cat < ActiveRecord::Base
  COLORS = ['red', 'orange', 'aquamarine', 'black', 'plaid', 'rainbowpoptart']
  SEXES = ['M','F', 'Unknown']


  has_many :cat_rental_requests,
    dependent: :destroy

  belongs_to :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  validates :birth_date, :name, :user_id, presence: true
  validate :color_validation, :sex_validation

  def self.colors
    COLORS
  end

  def self.sexes
    SEXES
  end

  def sex_validation
    unless self.class.sexes.include? sex
      errors[:sex] << "not a valid cisnormative sex"
    end
  end

  def color_validation
    unless self.class.colors.include? color
      errors[:color] << "not a valid color"
    end
  end

  def age
    (Date.today - birth_date).to_i / 365
  end

  def to_s
    " #{name}, #{age}, #{color} "
  end
end
