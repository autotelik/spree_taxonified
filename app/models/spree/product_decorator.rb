Product.class_eval do

  has_many :enquiries

  has_many :products_taxons, :dependent => :destroy
  has_many :taxons, :through => :products_taxons, :order => :position

  before_validation_on_create :ensure_master_variant
  after_create :add_properties_and_option_types_from_prototype
 
  # method that returns the single master variant
  alias_method :variant, :master

  delegate_belongs_to :master, :is_purchasable, :is_private, :is_enquirable, :is_physical

  scope :available, lambda { |*args|
    if(UserSession.current_user && UserSession.current_user.role?(:admin))
      { :joins => :variants_including_master, :conditions => ["available_on <= ? ", (args.first || Time.zone.now)] }
    else
      { :joins => :variants_including_master, :conditions => ["variants.is_private != true and available_on <= ? ", (args.first || Time.zone.now)] }
    end
  }

  named_scope :not_deleted, lambda { |*args|
    if(UserSession.current_user && UserSession.current_user.role?(:admin))
      { :joins => :variants_including_master, :conditions => "variants.deleted_at is null and variants.is_master = true" }
    else
      { :joins => :variants_including_master, :conditions => "variants.is_private != true and variants.is_master = true and variants.deleted_at is null" }
    end
  }
  named_scope :all_master, :include => :variants_including_master, :conditions => ["variants.is_master = true"]

  alias_method :variants?, :has_variants?

  # Over ride usual method .. add is_physical check
  def has_stock?
    return true if(master.is_physical == false)
    master.in_stock? || !!variants.detect{|v| v.in_stock?}
  end

  def ensure_master_variant
    if self.master.nil?
      self.master = Variant.new(:product => self, :is_master => true)
    else
      self.master.is_master = true
    end
  end

end
