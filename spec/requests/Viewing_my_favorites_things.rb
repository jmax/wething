require "spec_helper"

feature "Viewing my favorites" do
  given!(:thing)  { create(:thing) }
  given!(:favoriter) { create(:user) }

  background do
    favoriter.company = thing.user.company
    favoriter.save
    favoriter.favorite(thing)
  end

  scenario "click my favorites" do
    login_with favoriter

    click_on("My favorites")

    expect(current_path).to eql('/my/favorites')
    expect(page).to have_selector("#things")
    expect(page).to have_selector("#things div h3",            text: thing.url)
    expect(page).to have_selector("#things div p.description", text: thing.description)
    expect(page).to have_selector("#things div p.author",      text: thing.user.first_name)
  end
end
