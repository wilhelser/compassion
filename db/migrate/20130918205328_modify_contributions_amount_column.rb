class ModifyContributionsAmountColumn < ActiveRecord::Migration
  def change
    change_column :contributions, :amount, :decimal, :precision => 8, :scale => 2, :null => false
  end
end
