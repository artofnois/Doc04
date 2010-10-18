class CreateHistoricos < ActiveRecord::Migration
  def self.up
    create_table :historicos do |t|
      t.string :ambito
      t.string :contenido

      t.timestamps
    end
  end

  def self.down
    drop_table :historicos
  end
end
