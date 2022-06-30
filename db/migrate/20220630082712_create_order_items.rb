class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false
      t.string :sku, null: false
      t.decimal :price, default: 0, precision: 10, scale: 2
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
