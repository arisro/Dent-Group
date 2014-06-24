class AddShortDescriptionToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :short_description, :string
  end
end
