class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.string :ident
      t.string :name
      t.boolean :has_optin

      t.timestamps
    end
  end
end
