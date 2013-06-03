class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.integer :commentable_id
      t.integer :comment_id
      t.string :commentable_type
      t.datetime :created_at
      t.datetime :updated_at
      t.references :story

      t.timestamps
    end
    add_index :comments, :story_id
  end

  def self.down
    drop_table :comments
  end
end
