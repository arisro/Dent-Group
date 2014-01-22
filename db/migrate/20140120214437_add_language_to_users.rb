class AddLanguageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :language, :string, limit: 5, default: 'en'
  end
end
