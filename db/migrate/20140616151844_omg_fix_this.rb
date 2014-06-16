class OmgFixThis < ActiveRecord::Migration
  def change
    create_table :homepage_messages_categories do |t|
      t.string :ident
      t.boolean :deleted, default: false
      t.timestamps
    end
    add_column :homepage_messages, :homepage_messages_category_id, :integer
  end
end
