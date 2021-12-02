class CreateContributors < ActiveRecord::Migration[6.1]
  def change
    create_table :contributors do |t|
      t.references :list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role, default: 0

      t.timestamps
    end

    add_index :contributors, [:user_id, :list_id], unique: true
  end
end
