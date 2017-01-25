class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :status
      t.references :user
      t.references :event
      t.timestamps
    end
  end
end
