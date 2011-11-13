class UpdateTutorial < ActiveRecord::Migration
  def up
    add_column :tutorials, :title, :string
    add_column :tutorials, :user_id, :integer
    add_column :tutorials, :content, :text
    add_column :tutorials, :vs_address, :string
  end

  def down
    remove_column :tutorials, :title
    remove_column :tutorials, :user_id
    remove_column :tutorials, :content
    remove_column :tutorials, :vs_address

  end
end
