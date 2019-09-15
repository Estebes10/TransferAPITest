class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :clabe,    lenght: 16,              null: false
      t.decimal :balance, precision: 10, scale: 2, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :accounts, :clabe, unique: true
  end
end
