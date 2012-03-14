class OpenIdAdditions < ActiveRecord::Migration
  def up
    remove_column :users, :password_hash
    remove_column :users, :password_salt

    add_column :users, :third_party_uid, :string
    add_column :users, :third_party_provider, :string

    add_index :users, :third_party_uid

    create_table :profiles do |t|
      t.integer :user_id
      t.string :full_name
      t.text :description
      t.timestamps
    end
  end

  def down
    remove_column :users, :third_party_uid
    remove_column :users, :third_party_provider

    drop_table :profiles
  end
end
