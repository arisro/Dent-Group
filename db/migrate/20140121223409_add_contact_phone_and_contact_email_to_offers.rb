class AddContactPhoneAndContactEmailToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :contact_phone, :string
    add_column :offers, :contact_email, :string
  end
end
