class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|

      t.timestamps
    end
  end
end
