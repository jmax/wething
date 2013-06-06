require "spec_helper"

feature "User Accounts Signup" do
  background do
    visit root_url

    click_on "Sign up"
  end

  scenario "submitting valid data" do
    expect(User.count).to eql(0)
    expect(Company.count).to eql(0)

    expect(current_path).to eql(new_user_registration_path)

    fill_in "user[company_attributes][name]", with: "The Hulk!"
    fill_in "user[first_name]",               with: "Bruce"
    fill_in "user[last_name]",                with: "Banner"
    fill_in "user[email]",                    with: "banner@thehulk.com"
    fill_in "user[password]",                 with: "123123123"
    fill_in "user[password_confirmation]",    with: "123123123"

    click_on "Sign up"

    expect(User.where(email: "banner@thehulk.com")).to_not be_empty
    user = User.last
    expect(user.company_name).to eql("The Hulk!")

    welcome_message = "Welcome! You have signed up successfully."
    expect(page).to     have_selector("p",    text: welcome_message)
    expect(page).to     have_selector("span", text: user.first_name)
    expect(page).to     have_selector("span", text: user.company_name)

    expect(current_path).to eql(root_path)
  end

  scenario "submitting an existing company name" do
    user = create(:user)
    expect(User.count).to eql(1)
    expect(Company.count).to eql(1)

    expect(current_path).to eql(new_user_registration_path)

    fill_in "user[company_attributes][name]", with: user.company_name
    fill_in "user[first_name]",               with: "Bruce"
    fill_in "user[last_name]",                with: "Banner"
    fill_in "user[email]",                    with: "banner@thehulk.com"
    fill_in "user[password]",                 with: "123123123"
    fill_in "user[password_confirmation]",    with: "123123123"

    click_on "Sign up"

    expect(User.where(email: "banner@thehulk.com")).to be_empty
    expect(Company.count).to eql(1)

    error_message = "Company name has already been taken"
    expect(page).to have_selector("li", text: error_message)

    expect(current_path).to eql('/users')
  end

  scenario "submitting an empty form" do
    expect(current_path).to eql(new_user_registration_path)

    click_on "Sign up"

    expect(User.count).to eql(0)
    expect(Company.count).to eql(0)

    expect(page).to have_selector("li", text: "Email can't be blank")
    expect(page).to have_selector("li", text: "Password can't be blank")
    expect(page).to have_selector("li", text: "Company name can't be blank")
    expect(page).to have_selector("li", text: "First name can't be blank")
    expect(page).to have_selector("li", text: "Last name can't be blank")

    expect(current_path).to eql('/users')
  end
end
