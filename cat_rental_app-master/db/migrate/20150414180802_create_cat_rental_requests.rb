class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.references :cat, index: true, foreign_key: true, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status

      t.timestamps null: false
    end

    change_column_default :cat_rental_requests, :status, default:'PENDING'

  end
end
