class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images, id: :uuid do |t|
      t.string :title, null: false
      t.string :tags,  array: true
      t.string :description, null: false
      t.boolean :public_view, null: false, default: true
      t.references :user, type: :uuid, null: false        
      t.timestamps
    end
  end
end
