class UpdateRoleInUser < ActiveRecord::Migration
  def self.up
    change_column :users, :role, :string, :default => "author"
  end
end
