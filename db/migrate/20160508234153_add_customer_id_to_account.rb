class AddCustomerIdToAccount < ActiveRecord::Migration
  
  def up
    add_column :accounts, :customer_id, :string
  end

  def down
  	remove_column :accounts, :customer_id
  end

end
