class AddNukeActionToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :nuke_action, :string, :default => "nuke"
  end
end
