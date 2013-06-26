class AddBlastActionToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :blast_action, :string, :default => "blast"
  end
end
