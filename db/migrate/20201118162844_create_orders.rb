class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :reference
      t.string :purchase_channel
      t.string :clien_name
      t.string :address
      t.string :delivery_service
      t.text :line_items
      t.integer :status
      t.references :batch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
