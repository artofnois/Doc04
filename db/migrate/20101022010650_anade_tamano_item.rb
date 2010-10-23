class AnadeTamanoItem < ActiveRecord::Migration
  def self.up
    add_column :items, :tamano, :int
  end

  def self.down
    remove_column :items, :tamano
  end
end