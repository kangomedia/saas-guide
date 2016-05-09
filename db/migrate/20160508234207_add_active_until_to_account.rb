class AddActiveUntilToAccount < ActiveRecord::Migration
  
  def up
    add_column :accounts, :active_until, :datetime
  end

  def down
  	remove_column :accounts, :active_until
  end
  
end
