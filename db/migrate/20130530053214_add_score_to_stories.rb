class AddScoreToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :score, :integer, :default => 1
  end
end
