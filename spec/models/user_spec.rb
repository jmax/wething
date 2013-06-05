require 'spec_helper'

describe User do

let(:user) {
    User.new(
      first_name: "Bruce",
      last_name: "Banner",
      email: "bruce@thehulk.com",
      password: "123123123",
      password_confirmation: "123123123",
      company_attributes: { name: "The Hulk!" }
    )
  }

  describe "Validations" do
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "Associations" do
    it { should belong_to(:company) }
  end

  describe "Delegators" do
    before(:each) do
      user.save
    end

     describe "#company_name" do
      it "delegates company_name to Company" do
        expect(user.company_name).to eql("The Hulk!")
      end
    end
  end

  describe "Company creation" do
    context "with company attributes present" do
      it "creates a new company" do
        expect{user.save}.to change{Company.count}.by(1)
      end

      it "associates the company to the user" do
        user.save
        expect(user.company).to eql(Company.last)
      end
    end

    context "without company attributes present" do
      it "requires company name to be present" do
        subject.company_attributes = { name: nil }
        expect(subject).to_not be_valid
        expect(subject).to have_at_least(1).errors_on(:company)
        expect(subject).to have_at_least(1).errors_on("company.name")
      end
    end
  end
end
