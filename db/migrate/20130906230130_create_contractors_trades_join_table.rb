class CreateContractorsTradesJoinTable < ActiveRecord::Migration
    def change
    create_table :contractors_trades, :id => false do |t|
      t.references :contractor, :trade
    end

    add_index :contractors_trades, [:contractor_id, :trade_id],
      name: "contractors_trades_index",
      unique: true
  end
end
