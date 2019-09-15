class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name, limit: 64, null: false
      t.string :code, limit: 16, null: false
      t.belongs_to :user

      t.timestamps
    end

    add_index :roles, :code, unique: true
  end
end
