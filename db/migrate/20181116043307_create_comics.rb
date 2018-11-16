class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.string :title
      t.string :url
      t.string :thum_url
      t.integer :site_id

      t.timestamps
    end
  end
end
