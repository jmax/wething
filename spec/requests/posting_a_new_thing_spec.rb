require "spec_helper"

feature "Posting a New Thing" do
  given!(:user) { create(:user) }

  scenario "with valid data" do
    expect(Thing.count).to eql(0)

    login_with user
    click_on "Thing something!"

    fill_in "thing[url]",         with: "http://www.google.com"
    fill_in "thing[description]", with: "something to say"

    click_on "Thing this!"

    expect(Thing.where(url: "http://www.google.com")).to_not be_empty
    thing = Thing.last
    expect(user.things).to include(thing)
    expect(user.company.things).to include(thing)

    expect(current_path).to eql(root_path)
  end

  scenario "with an invalid URL" do
    login_with user
    click_on "Thing something!"

    fill_in "thing[url]",         with: "acme!"
    fill_in "thing[description]", with: "something to say"

    click_on "Thing this!"
    expect(Thing.count).to eql(0)
    expect(Thing.where(url: "acme!")).to be_empty

    expect(page).to have_selector("li", text: "Url is invalid")

    expect(current_path).to eql('/things')
  end

  scenario "with an existing URL" do
    login_with user
    click_on "Thing something!"

    fill_in "thing[url]",         with: "http://www.google.com"
    fill_in "thing[description]", with: "something to say"

    click_on "Thing this!"
    expect(Thing.count).to eql(1)

    click_on "Thing something!"

    fill_in "thing[url]",         with: "http://www.google.com"
    fill_in "thing[description]", with: "other description"

    click_on "Thing this!"

    expect(Thing.count).to eql(1)

    expect(page).to have_selector("li", text: "Url has already been taken")

    expect(current_path).to eql('/things')
  end

  scenario "submitting an empty thing" do
    login_with user
    click_on "Thing something!"

    click_on "Thing this!"

    expect(Thing.count).to eql(0)

    expect(page).to have_selector("li", text: "Url can't be blank")
    expect(page).to have_selector("li", text: "Description can't be blank")

    expect(current_path).to eql('/things')
  end

  scenario "canceling the operation" do
    login_with user
    click_on "Thing something!"

    click_on "Cancel"

    expect(current_path).to eql(root_path)
  end

  scenario "without a logged in user" do
    visit thing_this_url
    expect(current_path).to eql(new_user_session_path)
  end
end
