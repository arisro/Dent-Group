class ChangeSupplierCommentsDeleted < ActiveRecord::Migration
  def change
  	change_column :supplier_comments, :deleted, :boolean, default: false
  end
end
