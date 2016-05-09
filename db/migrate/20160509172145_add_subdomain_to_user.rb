class AddSubdomainToUser < ActiveRecord::Migration
  
  def up
    add_column :users, :subdomain, :string
  end

  def down
    remove_column :users, :subdomain
  end

end
