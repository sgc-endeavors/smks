require 'spec_helper'

 describe "Registration Page" do
   it "includes a page title" do
     visit new_user_path#"/users/new"
     expect(page).to have_content("smks")
     
   end
 end