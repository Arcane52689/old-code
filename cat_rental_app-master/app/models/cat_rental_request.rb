class CatRentalRequest < ActiveRecord::Base
  belongs_to :cat
  belongs_to :user

  validates :user_id, :cat_id, :start_date, :end_date, presence: true
  validate :start_before_end, :no_overlapping_approved_requests

  def approve!
    if update(status: 'APPROVED')
      overlapping_pending_requests.update_all(status: 'DENIED')
    else
      errors[:status] << "Request conflicts with an already approved rental"
    end
  end

  def deny!
    update!(status: 'DENIED')
  end

  def other_requests_for_same_cat
    CatRentalRequest
      .where(cat_id: cat_id)
      .where('id <> ? OR ? IS NULL', id, id)
  end

  def overlapping_requests
    other_requests_for_same_cat
      .where('? <= end_date AND ? >= start_date', start_date, end_date)
    end

  def overlapping_approved_requests
    overlapping_requests
      .where(status: 'APPROVED')
  end

  def overlapping_pending_requests
    overlapping_requests
      .where(status: 'PENDING')
  end

  def no_overlapping_approved_requests
    if overlapping_approved_requests.any?
      errors[:status] << "Request conflicts with approved rental."
    end
  end

  def start_before_end
    if end_date && start_date && end_date < start_date
      errors[:end_date] << "End date must be later than start date."
    end
  end
end
