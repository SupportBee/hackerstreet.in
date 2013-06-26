class AddTextToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :text, :string
  end
end
