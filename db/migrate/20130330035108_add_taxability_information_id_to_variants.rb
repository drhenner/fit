class AddTaxabilityInformationIdToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :taxability_information_id, :integer
    add_index  :variants, :taxability_information_id
  end
end
