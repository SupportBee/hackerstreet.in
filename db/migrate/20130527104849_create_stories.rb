class CreateStories < ActiveRecord::Migration
   def self.up
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
