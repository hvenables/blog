class CreateLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.string :uuid
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:uuid, :article_id], unique: true
  end
end
