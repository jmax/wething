require 'spec_helper'

describe Thing do
  describe "Validations" do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:url).scoped_to(:company_id) }

    describe "URL format" do
      it "requires URL to have a valid format" do
        subject.url = "acme!"
        expect(subject).to_not be_valid
        expect(subject).to have_at_least(1).errors_on(:url)
      end
    end
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:company) }
  end
end
