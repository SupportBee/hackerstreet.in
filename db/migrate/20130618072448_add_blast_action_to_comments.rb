class AddBlastActionToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :blast_action, :string, :default => "blast"
  end
end
