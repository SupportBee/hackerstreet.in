class AddDeadToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :dead, :boolean, :default => "false"
  end
end
