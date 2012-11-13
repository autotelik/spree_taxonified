module Spree
  
  Taxon.class_eval do

    has_many :products_taxons, :order => :position
    has_many :products, :through => :products_taxons

    accepts_nested_attributes_for :products_taxons, :allow_destroy => true


    named_scope :for_menu,  lambda { |*args| { :conditions => ["menu = ?", args.first || 'top'], :order => :menu_priority } }

    def css_name
      self.name.gsub(' ','_')
    end

  end

end