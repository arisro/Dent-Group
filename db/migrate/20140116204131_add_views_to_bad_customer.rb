class AddViewsToBadCustomer < ActiveRecord::Migration
  def change
  	add_column :bad_customers, :views, :integer
  end
end
