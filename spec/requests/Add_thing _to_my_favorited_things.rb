require "spec_helper"

feature "Viewing a Thing" do
  given!(:thing)  { create(:thing) }
  given!(:favoriter) { create(:user) }

  background do
    favoriter.company = thing.user.company
    favoriter.save
  end

  scenario "add to my favorites" do
    login_with favoriter

    click_on("Add to my favorites")

    expect(favoriter.user_favorites).to include(thing)
    expect(current_path).to eql(root_path)
    expect(page).to have_selector("p", text: "The thing was added to favorites.")
  end

  scenario "try adding one thing to favorites already been added" do
    login_with favoriter
    click_on("Add to my favorites")
    expect(favoriter.user_favorites).to include(thing)
    visit root_path
    click_on("Add to my favorites")

    expect(favoriter.user_favorites).to_not include(thing)
    expect(current_path).to eql(root_path)
    expect(page).to have_selector("p", text: "The thing is already a favorite.")
  end

  scenario "add to my favorites without logging in" do
    visit new_thing_user_favorite_path(thing)

    expect(current_path).to eql(new_user_session_path)
  end
end
