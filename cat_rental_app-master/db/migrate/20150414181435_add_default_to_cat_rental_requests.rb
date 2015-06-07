class AddDefaultToCatRentalRequests < ActiveRecord::Migration
  def change
    change_column_default :cat_rental_requests, :status, 'PENDING'

  end
end
