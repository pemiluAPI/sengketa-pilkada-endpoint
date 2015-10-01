class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :constituency

      t.timestamps
    end
  end
end
