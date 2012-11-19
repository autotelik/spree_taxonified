class ProdTaxonsThrough  < ActiveRecord::Migration

  def self.up
   add_column :spree_products_taxons, :id, :primary_key
   add_column :spree_products_taxons, :position, :integer, :default => 0
   
    # top, bottom, left, right, sidebar, footer etc
   add_column :spree_taxons,  :menu, :string, :limit => 12
   add_column :spree_taxons,  :menu_index, :integer, :default => 0

  end

  def self.down
   remove_column :spree_products_taxons, :id
   remove_column :spree_products_taxons, :position
   remove_column :spree_taxons,  :menu
   remove_column :spree_taxons,  :menu_index
  end
end
