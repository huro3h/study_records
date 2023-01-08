class AddLoginIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :login_id, :string
  end
end
