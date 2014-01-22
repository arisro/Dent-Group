class AddPaidUntilToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :paid_until, :datetime
  end
end
