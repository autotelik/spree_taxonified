require 'spec_helper'

describe "Product Taxons" do
  stub_authorization!

  before(:each) do
    visit spree.admin_products_path
  end
    
  context "visiting the products tab" do

    # make sure existing stuff not broken
    it "should have a link to products" do
      within(:css, '#sub-menu') { page.find_link("Products")['/admin/products'] }
    end

    it "should have a link to option types" do
      within(:css, '#sub-menu') { page.find_link("Option Types")['/admin/option_types'] }
    end

    it "should have a link to properties" do
      within(:css, '#sub-menu') { page.find_link("Properties")['/admin/properties'] }
    end

    it "should have a link to prototypes" do
      within(:css, '#sub-menu') { page.find_link("Prototypes")['/admin/prototypes'] }
    end
 
    # new extension links

    it "should have a link to product taxons" do
      within(:css, '#sub-menu') { page.find_link("Products Taxons")['/admin/product_taxons'] }
    end
    
  end
  
  context "listing product taxons" do
    
    it "should list existing product taxons" do
      click_link "Products Taxons"
    end
  end

end
