class AddAncestryToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :ancestry, :string
    add_index :comments, :ancestry
  end

  def self.down
    remove_index :comments, :ancestry
    remove_column :comments, :ancestry
  end
end
