module Spree
  module Core
    module Search
      class Base
 

        def retrieve_products
          @products_scope = get_base_scope
          curr_page = page || 1

          @products = @products_scope.includes([:master]).page(curr_page).per(per_page)
          
          @products = @products.sort do |p1, p2|
            t1 = p1.products_taxons.detect{|pt| pt.taxon == @taxon}; t2 = p2.products_taxons.detect{|pt| pt.taxon == @taxon};
            pos1 = t1 ? t1.position : 0; pos2 = t2 ? t2.position : 0
            pos1 <=> pos2
          end
          @products
    
        end

      end
    end
  end
end
