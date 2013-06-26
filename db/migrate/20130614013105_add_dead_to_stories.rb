class AddDeadToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :dead, :boolean, :default => "false"
  end
end
