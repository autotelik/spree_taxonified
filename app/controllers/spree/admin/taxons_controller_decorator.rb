module Spree
  module Admin
    TaxonsController.class_eval do
      before_filter :load_object, :only => [:set_page, :selected, :available, :remove]
      before_filter :load_pages, :only => [:index, :new, :edit, :selected]


      def reorder_products
 
        @taxon = Taxon.find(params[:id])
        if(@taxon)
          # Not sure how or if possible to do this all in one line @taxon.update_attributes chokes
          params[:taxon][:products_taxons].each do |id, attributes|
            x = ProductsTaxon.find(id)
            x.update_attributes( attributes) if(x)
          end if params[:taxon][:products_taxons]
    
          respond_to do |format|
            format.html
            format.js  { render :nothing => true, :status => :ok }
          end
        end

      end

      def set_page
        @taxon.update_attributes( :page_id => params[:page] )
      end

      # Over ride existing method to call set_available
      def selected
        @taxons = @product.taxons
        set_available
      end

      # AJAX method for selecting an existing ProductProperty and associating with the current product
      def select
        @product = Product.find(params[:product_id])
        @taxon = Taxon.find(params[:id])
        @product.taxons << @taxon
        @product.save
        @product.reload
        set_available
        render :partial => 'table', :layout => false
      end

      def remove
        @product.taxons.delete(@taxon)
        @product.save
        @product.reload
        set_available
        respond_to do |format|
          format.html
          format.js {render :partial => 'available', :layout => false}
        end
      end

      # Called from the search function
      def available
        set_available
        respond_to do |format|
          format.html
          format.js {render :partial => 'available', :layout => false}
        end
      end

      def set_available
        if params[:q].blank?
          @available = Taxon.find(:all, :order => 'name')
        else
          @available = Taxon.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:q].downcase}%"])
        end
        @available = @available - @product.taxons
      end

      private
  
      def load_pages
        @pages = Page.all
      end

    end
  end
end