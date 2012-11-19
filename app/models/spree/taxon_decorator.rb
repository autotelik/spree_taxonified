module Spree
  
  Taxon.class_eval do

    MENU_LOCATIONS = [:top, :left, :right, :bottom, :sidebar, :footer]
    
    has_many :products_taxons
    has_many :products, :through => :products_taxons

    accepts_nested_attributes_for :products_taxons, :allow_destroy => true

    attr_accessible :menu, :menu_index
    
    # TODO - research who 'def applicable_filters' works, 
    # could/should we add the ProductsTaxons ordering as a filter ?
           
    scope :for_menu,  lambda { |*args| { :conditions => ["menu = ?", args.first || :top], :order => :menu_index } }

    def css_name
      self.name.gsub(' ','_')
    end

  end

end