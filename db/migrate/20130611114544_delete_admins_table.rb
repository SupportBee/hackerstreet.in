class DeleteAdminsTable < ActiveRecord::Migration
  def self.up
    drop_table :admins
  end
end
