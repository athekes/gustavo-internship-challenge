class MonetizeOrder < ActiveRecord::Migration[6.0]
  def change
    add_monetize :orders, :total_value
  end
end
