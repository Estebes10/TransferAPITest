class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name,            limit: 64, null: false
      t.string :password_digest,            null: false
      t.string :email,           limit: 64, null: false
      t.belongs_to :role

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
