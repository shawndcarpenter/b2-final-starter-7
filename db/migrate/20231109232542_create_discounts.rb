class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.integer :threshold
      t.integer :percentage
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
