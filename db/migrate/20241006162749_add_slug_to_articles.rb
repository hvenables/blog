class AddSlugToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :slug, :string
    add_index :articles, :slug, unique: true
  end
end
