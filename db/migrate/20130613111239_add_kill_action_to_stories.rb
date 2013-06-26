class AddKillActionToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :kill_action, :string, :default => "kill"
  end
end
