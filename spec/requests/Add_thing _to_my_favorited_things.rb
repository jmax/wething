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
  end
end
