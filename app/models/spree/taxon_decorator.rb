module Spree
  
  Taxon.class_eval do

    has_many :products_taxons, :order => :position
    has_many :products, :through => :products_taxons

    accepts_nested_attributes_for :products_taxons, :allow_destroy => true


    # Deleting root taxon is deadly  - delete through Taxonomy
    before_destroy :ensure_not_root
  
    def ensure_not_root
      return false if self.taxonomy && self.parent_id.nil?
    end

    belongs_to :page

    named_scope :for_menu,  lambda { |*args| { :conditions => ["menu = ?", args.first || 'topNav'], :order => :menu_priority } }

    def css_name
      self.name.gsub(' ','_')
    end

  end

end