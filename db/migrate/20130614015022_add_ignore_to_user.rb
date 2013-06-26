class AddIgnoreToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :ignore, :boolean, :default => "false"
  end
end
