class CreateComicsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :comics_users,id: false do |t|
      t.references :comic, foreign_key: true,null: false
      t.references :user, foreign_key: true,null: false
    end
  end
end
