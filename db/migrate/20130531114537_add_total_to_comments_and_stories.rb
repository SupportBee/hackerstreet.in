class AddTotalToCommentsAndStories < ActiveRecord::Migration
  def self.up
    add_column :comments, :total, :float, :precision => 15
    add_column :stories, :total, :float, :precision => 15
  end
end
