require "spec_helper"

feature "Homepage" do
  given!(:user) { create(:user) }

  scenario "without a logged in user" do
    visit root_url

    expect(page).to     have_link("Sign in")
    expect(page).to     have_link("Sign up")
    expect(page).to_not have_link("Sign out")
    expect(page).to_not have_selector("#things")
  end

  scenario "with a logged in user" do
    login_with user
    visit root_url

    expect(page).to     have_link("Sign out")
    expect(page).to_not have_link("Sign in")
    expect(page).to_not have_link("Sign up")
    expect(page).to     have_selector("a", text: user.first_name)
    expect(page).to     have_selector("span", text: user.company_name)
  end

  scenario "listing things" do
    login_with user
    post_a_new_thing

    visit root_url

    thing = Thing.last

    expect(page).to have_selector("#things")
    expect(page).to have_selector("#things div h3",            text: thing.url)
    expect(page).to have_selector("#things div p.description", text: thing.description)
    expect(page).to have_selector("#things div p.author",      text: thing.user.first_name)
  end

  scenario "listing things with long description" do
    login_with user

    click_on "Thing something!"
    fill_in "thing[url]",         with: "http://stackoverflow.com/questions/16423299/rails-4-rspec-capybara-webkit-server"
    fill_in "thing[description]", with: "something to say"
    click_on "Thing this!"

    thing = Thing.last

    expect(page).to have_selector("#things div h3", text: thing.url.truncate(57))
  end
end
