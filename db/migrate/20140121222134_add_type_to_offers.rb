class AddTypeToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :type, :integer, null: false
  end
end
