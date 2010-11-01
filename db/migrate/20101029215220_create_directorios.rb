class CreateDirectorios < ActiveRecord::Migration
  def self.up
    create_table :directorios do |t|
      t.string :padre
      t.string :directorio
      
      t.timestamps
    end
  end

  def self.down
    drop_table :directorios
  end
end
