require 'rails_helper'

feature "Books", js:true do

  before :all do
    book_isbns = ["0061122416", "014241543X", "1594206147", "0385345623", "080509668X", "0385539703", "1250054052", "0545685176"]
    user = create :user
    book_isbns.each do |isbn|
      VCR.use_cassette("google_book_#{isbn}") do
        create_book(user, isbn)
      end
    end
  end

  def create_book(user, isbn)
    b = user.created_books.new(isbn: isbn)
    b.book_data_lookup
    b.save!
  end

  shared_examples "an index page" do

    before :each do
      visit books_path
    end

    it "should display the first five books when loaded" do
      expect( page ).to have_css(".media", count: 5)
    end

    it "should display all books after a scroll" do
      page.execute_script('window.scrollTo(0,100000)')
      expect( page ).to have_css(".media", count: 7)
    end

    it "should display book details" do
      within('.books') do
        b = Book.first
        expect( page ).to have_content( b.title )
        expect( page ).to have_content( b.author )
        expect( page ).to have_content( b.description)
        expect( page ).to have
      end
    end

    it "should filter by categories when they are clicked on" do
      category = first('.category-link')
      category.click
      page.all('.category-link') { expect(page).to have_content( category )}
    end
  end

  describe "when user goes to the books index page" do

    before :each do
      @user = create :user
    end

    describe "when the user is logged in" do
      before :each do
        login @user
      end
      it_behaves_like "an index page"
    end

    describe "when the user is not logged in" do
      it_behaves_like "an index page"
    end
  end
end
