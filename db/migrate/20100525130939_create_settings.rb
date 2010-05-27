class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :key
      t.string :name
      t.text :value
      t.string :datatype
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :settings
  end
end