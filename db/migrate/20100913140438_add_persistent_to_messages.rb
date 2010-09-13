class AddPersistentToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :persistent, :boolean
  end

  def self.down
    remove_column :messages, :persistent
  end
end
