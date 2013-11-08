require 'spec_helper'

 describe "Registration Page" do
    subject { page }
   
   it "includes a page title" do
    
     visit new_user_path#"/users/new"
     #expect(page).to have_content("smks")
     #has_content?("smks")
     #page.should have_content("sasd")
     within("h1") do
      should have_content("smks")
     end
     current_path.should == "/users/new"
   end
 end