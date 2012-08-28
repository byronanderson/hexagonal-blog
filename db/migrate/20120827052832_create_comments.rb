class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :body
      t.integer :blog_post_id
      t.timestamp :removed_at

      t.timestamps
    end
  end
end
