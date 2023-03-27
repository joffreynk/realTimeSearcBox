class CreateQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :queries do |t|
      t.string :query, null:false
      t.integer :times
      t.string :userip, null:false-

      t.timestamps
    end
  end
end
