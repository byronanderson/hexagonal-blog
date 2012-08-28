class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.boolean :enable_comments, :default => true

      t.timestamps
    end
  end
end
