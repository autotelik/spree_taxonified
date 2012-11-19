# Added a position column to enable ordering other than by name

module Spree
  class ProductsTaxon < ActiveRecord::Base
    belongs_to :product
    belongs_to :taxon

    #acts_as_list :scope => :taxon
          
    default_scope :order => '0+spree_products_taxons.position ASC'

    
    before_save :set_position

    protected

    def set_position
      self.position ||= 1 + (ProductsTaxon.where('txon_id=?', taxon_id).maximum(:position) || 0)
    end

  end
end
