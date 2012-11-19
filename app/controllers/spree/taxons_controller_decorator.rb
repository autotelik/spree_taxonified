module Spree
  
  TaxonsController.class_eval do
 
    private
    def load_data
      @taxon ||= object
      retrieve_products

      @products = @products.sort do |p1, p2|
        t1 = p1.products_taxons.detect{|pt| pt.taxon == @taxon}; t2 = p2.products_taxons.detect{|pt| pt.taxon == @taxon};
        pos1 = t1 ? t1.position : 0; pos2 = t2 ? t2.position : 0
        pos1 <=> pos2
      end
      @products
    end

  end
end
