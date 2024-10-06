class AddSubTitleAndSummaryToArticles < ActiveRecord::Migration[7.2]
  def change
    change_table(:articles, bulk: true) do |t|
      t.string :sub_title
      t.text :summary
    end
  end
end
