module Spree
  Product.class_eval do

    has_many :products_taxons, :dependent => :destroy
    has_many :taxons, :through => :products_taxons, :order => :position
  end
end
