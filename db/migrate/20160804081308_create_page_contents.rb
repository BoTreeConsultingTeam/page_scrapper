class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.references :page, foreign_key: true
      t.integer :tag_type
      t.text :tag_content

      t.timestamps null: false
    end
  end
end
