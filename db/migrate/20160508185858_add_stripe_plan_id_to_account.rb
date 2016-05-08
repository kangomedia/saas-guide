class AddStripePlanIdToAccount < ActiveRecord::Migration
  
  def up
    add_column :accounts, :stripe_plan_id, :string
  end

  def down 
  	remove column :accounts, :stripe_plan_id
  end

end
