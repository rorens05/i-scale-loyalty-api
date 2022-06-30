# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :transaction_id, null: false
      t.string :store_id, null: false
      t.string :guest_id, null: false
      t.datetime :timestamp, null: false
      t.decimal :discount, default: 0, precision: 10, scale: 2
      t.decimal :sub_total, default: 0, precision: 10, scale: 2
      t.decimal :points, default: 0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
