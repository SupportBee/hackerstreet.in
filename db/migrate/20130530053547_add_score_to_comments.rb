class AddScoreToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :score, :integer, :default => 1
  end
end
