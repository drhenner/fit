class ImageGroup < ActiveRecord::Base
  attr_accessible :name, :product_id, :images_attributes

  validates :name,  :presence => true
  validates :product_id,  :presence => true

  belongs_to :product
  has_many :variants
  has_many :images, :as         => :imageable,
                    :order      => :position,
                    :dependent  => :destroy

  accepts_nested_attributes_for :images, :reject_if => proc { |t| (t['photo'].nil? && t['photo_from_link'].blank?) }, :allow_destroy => true

  def image_urls(image_size = :small)
    images.empty? ? product.image_urls(image_size) : images.map{|i| i.photo.url(image_size)}
  end
end
