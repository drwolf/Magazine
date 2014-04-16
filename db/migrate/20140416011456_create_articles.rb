class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.integer :site_id
      t.text :summary

      t.timestamps
    end
  end
end
