class TutorialSlug < ActiveRecord::Migration
  def up
    add_column :tutorials, :slug, :string
  end

  def down
    remove_column :tutorials, :slug
  end
end
