require "spec_helper"

feature "Homepage" do
  given!(:user) { create(:user) }

  scenario "without a logged in user" do
    visit root_url

    expect(page).to     have_link("Sign in")
    expect(page).to     have_link("Sign up")
    expect(page).to_not have_link("Sign out")
  end

  scenario "with a logged in user" do
    login_with user

    visit root_url

    expect(page).to     have_link("Sign out")
    expect(page).to_not have_link("Sign in")
    expect(page).to_not have_link("Sign up")
    expect(page).to     have_selector("span", text: user.first_name)
    expect(page).to     have_selector("span", text: user.company_name)
  end
end
