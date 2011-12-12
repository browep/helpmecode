class DraftDefault < ActiveRecord::Migration
  def up
    change_column_default :tutorials,:draft,true
  end

  def down
    change_column_default :tutorials,:draft,nil
  end
end
