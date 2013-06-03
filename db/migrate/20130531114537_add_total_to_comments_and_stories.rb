class AddTotalToCommentsAndStories < ActiveRecord::Migration
  def self.up
    add_column :comments, :total, :integer
    add_column :stories, :total, :integer
  end
end
