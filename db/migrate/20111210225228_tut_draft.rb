class TutDraft < ActiveRecord::Migration
  def up
    add_column :tutorials, :draft, :boolean, :default=>true
  end

  def down
    remove_column :tutorials, :draft
  end
end
