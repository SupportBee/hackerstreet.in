class AddKillActionToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :kill_action, :string, :default => "kill"
  end
end
