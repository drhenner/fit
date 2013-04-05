class ChangeTaxratesPercentageTo3Decimals < ActiveRecord::Migration
  def up
    change_column :taxrates, :percentage, :decimal,      :precision => 8, :scale => 3
  end

  def down
    change_column :taxrates, :percentage, :decimal,      :precision => 8, :scale => 3# don't let down work.
  end
end
