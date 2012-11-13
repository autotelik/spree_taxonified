Spree::Core::Engine.routes.draw do
  # Add your extension routes here
   
  namespace :admin do

    # TODO - how should this work ???
    # use put as essentially the select is to modify an existing entry with different product
     
    resources :products_taxons do
      put :select
      delete :remove
    end
  
    resources :taxons do
      put :reorder_products
    end
 
    resources :products do   
    end
    
  end
end