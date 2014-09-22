require 'rails_helper'

feature 'Avatar image upload' do
  it "let's a user upload an image on sign up" do
    visit new_user_registration_path
    page.attach_file "user[avatar]", Rails.root.join("public", "profile_default.gif")
    fill_in 'user[email]', with: "user@example.com"
    fill_in 'user[password]', with: "badpassword"
    fill_in 'user[password_confirmation]', with: "badpassword"
    click_button "Sign up"
    page.should have_css(".img-thumbnail", :count => 1)
    img = page.first(:css, ".img-thumbnail")
    visit img[:src]
    page.status_code.should be 200
  end

  it "let's a user replace an uploaded avatar" do
    @user = create :user
    login @user
    visit edit_user_registration_path
    page.attach_file "user[avatar]", Rails.root.join("public", "profile_default.gif")
    fill_in 'user[current_password]', with: @user.password
    click_button "Update"
    page.should have_css(".img-thumbnail", :count => 1)
    img = page.first(:css, ".img-thumbnail")
    visit img[:src]
    page.status_code.should be 200
  end
end
