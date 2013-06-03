class AddUserToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_id, :integer
  end
end
