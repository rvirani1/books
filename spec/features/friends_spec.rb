require 'rails_helper'

describe 'Friendships', js:true do
  before :each do
    @user = create :user
    login @user
    
    visit friendships_users_path
  end


  it 'should have a link to the Users page on header' do
    visit root_path
    within("#navigation-links") { expect( page ).to have_content("Friendships") }
  end

  describe "current friends tab" do

    it "should have a tab called current friends" do
      within('.friends-content') { expect( page ).to have_content( "Current Friends") }
    end

    it "should show a user's current friends tab" do
      expect( page ).to have_content("table")
    end


    it "should have a button to defriend existing frends"
  end

  it "should have a tab listing potential friends"

  it "should have a button to confirm a friend request"
  it "should have a tab of pending friend requests"
  it "should have a button to friend a user who is not a friend"
  it "shoudl not have a b utton to refriend users who are already friends"
end
