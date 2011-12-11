class TutorialSlugUniqueIndex < ActiveRecord::Migration
  def up
    add_index :tutorials, :slug, :unique=>true
  end

  def down
    remove_index :tutorials, :slug
  end
end
