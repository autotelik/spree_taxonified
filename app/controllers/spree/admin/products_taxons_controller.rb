module Spree
  
  module Admin
    class ProductsTaxonsController < ResourceController

      before_filter :load_object, :only => [:remove]

      def index
        @taxons = Spree::Taxon.find(:all, :order => 'name')
    
        # These Products will be available to be added to Taxons  
        @all_available_products = Spree::Product.active
      end

      def update_positions
        # the js table helper gives us back params list for 

        logger.info params.inspect 
        taxon = Spree::Taxon.find(params[:taxon_id])

        product_taxons = taxon ? taxon.products_taxons() : []
        
        puts "\n\n################## FIND IDS", product_taxons.inspect, params[:positions].inspect
        
        # js table helper gives list 4 every table (taxon) with the product_taxoins ids as VALUES
        # keys are the new position in the list
        # 
        # not nice if we have huge product/taxons lists but this is what the js returns us
        # so bit stuffed for now 
        
        params[:positions].each do |index, moved_pt_id| 
          break if(product_taxons.empty?)
        
          product_taxons.each_with_index do |pt, i| 
            if(pt.id == moved_pt_id.to_f)
              puts "MATCH #{pt.id} #{pt.position} => #{index}"
              pt.update_attribute(:position, index)
              product_taxons.delete_at(i)
              break
            end
          end
        end    
                
        respond_to do |format|
          format.html { redirect_to admin_product_variants_url(params[:taxon_id]) }
          format.js  { 
            message = taxon ? "Ok" : "Sorry could not find the supplied Taxon"
            render :text => message
          }
        end
      end
      
      # AJAX method for selecting a Product and associating with a Taxon
      
      # select_admin_taxon_products_taxons_url(taxon)
      
      def select
        
        logger.info params.inspect 
        taxon = Spree::Taxon.find(params[:taxon_id])

       # @product = Spree::Product.find(params[:product])
      #  @taxon   = Spree::Taxon.find(params[:id])

       # if(@product && @taxon)
       #   @product_taxon = Spree::ProductsTaxon.create(:taxon => @taxon, :product => @product)
       #   @taxon.reload
       # end

        #set_available


       # @update_table_dom = params[:dom]

      ##  respond_to do |format|
          format.html
       #   format.js  { render :partial => 'select', :layout => false}
        #end

      end

      # AJAX method for removing a Product from association with a Taxon

      def remove

        object.delete

        respond_to do |format|
          format.html
          format.js { render(:nothing => true) }
        end
      end


      def set_available
        @available = Spree::Product.active

        @available_products  = @available - @taxon.products
      end

    end
  end
end