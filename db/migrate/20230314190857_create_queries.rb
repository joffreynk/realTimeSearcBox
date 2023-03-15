class CreateQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :queries do |t|
      t.string :query, null:false
      t.integer :times
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :queries, :query
  end
end
