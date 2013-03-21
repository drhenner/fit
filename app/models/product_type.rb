class ProductType < ActiveRecord::Base
  acts_as_nested_set  #:order => "name"
  has_many :products, dependent: :restrict

  validates :name,    :presence => true, :length => { :maximum => 255 }

  FEATURED_TYPE_ID = 1

  # paginated results from the admin ProductType grid
  #
  # @param [Optional params]
  # @return [ Array[ProductType] ]
  def self.admin_grid(params = {})
    grid = ProductType
    grid = grid.where("product_types.name iLIKE ?", "#{params[:name]}%")              if params[:name].present?
    grid
  end

  def self.upsell_product_type_ids
    Rails.cache.fetch("upsell_product_type_ids", :expires_in => 3.hours) do
      ProductType.where("product_types.name NOT iLIKE ?", 'Media').pluck(:id)
    end
  end

end
