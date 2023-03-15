# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body

      t.timestamps
    end
    add_index :articles, :title
    add_index :articles, :body
  end
end
