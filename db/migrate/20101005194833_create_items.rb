class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :tipo
      t.string :titulo
      t.string :descripcion
      t.string :path
      t.string :fichero

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
