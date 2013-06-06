require "spec_helper"

feature "User Accounts Signin" do
  background do
    visit root_path

    click_on "Sign in"
  end

  scenario "logging in an existing user account" do
    user = create(:user)
    expect(current_path).to eql(new_user_session_path)

    fill_in "user[email]",    with: user.email
    fill_in "user[password]", with: "123123123"

    click_on "Sign in"

    expect(page).to     have_selector("p",    text: "Signed in successfully.")
    expect(page).to     have_selector("span", text: user.first_name)
    expect(page).to     have_selector("span", text: user.company_name)

    expect(current_path).to eql(root_path)
  end

  scenario "logging in a unexisting user account" do
    expect(current_path).to eql(new_user_session_path)

    click_on "Sign in"

    expect(page).to     have_selector("p", text: "Invalid email or password.")

    expect(current_path).to eql(new_user_session_path)
  end
end
