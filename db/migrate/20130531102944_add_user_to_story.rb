class AddUserToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :user_id, :integer
  end
end
