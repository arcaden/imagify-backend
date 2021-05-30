class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, id: :uuid  do |t|
      t.references :user, type: :uuid, null: false
      t.references :image, type: :uuid, null: false
      t.references :comment, type: :uuid
      t.string :text, null: false        
      t.timestamps
    end

    add_index :images, :tags
    add_index :images, :title
  end
end
