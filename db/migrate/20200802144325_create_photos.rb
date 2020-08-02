class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :pic_path
      t.string :pic_localization

      t.timestamps
    end
  end
end
