class CreateQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :queries do |t|
      t.string :query, null: false, unique: true
      t.integer :times, null: false, default: 0

      t.timestamps
    end
    add_index :queries, :query
  end
end
