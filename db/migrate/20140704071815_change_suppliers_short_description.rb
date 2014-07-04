class ChangeSuppliersShortDescription < ActiveRecord::Migration
  def change
    change_column :suppliers, :short_description, :text
  end
end
