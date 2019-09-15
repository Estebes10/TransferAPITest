class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :source_account,       lenght: 16, null: false
      t.string :destination_account,  lenght: 16, null: false
      t.decimal :amount,                          null: false

      t.timestamps
    end
  end
end
