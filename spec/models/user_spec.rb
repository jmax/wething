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
    it { should have_many(:things) }
    it { should have_many(:user_views) }
    it { should have_many(:viewed_things).through(:user_views)}
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
        expect(subject).to have_at_least(1).errors_on("company.name")
      end
    end
  end

  describe "#view" do
    before(:each) do
      @thing  = create(:thing)
      @author = @thing.user
      @viewer = create(:user)
    end

    context "when the viewer is not the thing author" do
      it "adds the thing to viewer's viewed things" do
        @viewer.view(@thing)
        expect(@viewer.viewed_things).to include(@thing)
      end

      it "increments views counter cache" do
        expect{
          @viewer.view(@thing)
        }.to change{ @thing.user_views.count }.by(1)
      end
    end

    context "when the viewer is the thing author" do
      it "does not add the thing to author's viewed things" do
        @author.view(@thing)
        expect(@author.viewed_things).to_not include(@thing)
      end

      it "does not increment views counter cache" do
        expect{
          @author.view(@thing)
        }.to_not change{ @thing.user_views.count }.by(1)
      end
    end

    context "when the viewer has already viewed the thing" do
      before(:each) do
        @viewer.view(@thing)
      end

      it "does not increment views counter cache" do
        expect(@thing.user_views.count).to eql(1)

        expect{
          @viewer.view(@thing)
        }.to_not change{ @thing.user_views.count }.by(1)
      end
    end
  end

  describe "#favorite" do
    before(:each) do
      @thing  = create(:thing)
      @favoriter = create(:user)
    end


    context "adding a thing to user's favorite"do

      it "include the thing to favorited things" do
        @favoriter.favorite(@thing)
        expect(@favoriter.favorited_things).to include(@thing)
      end
    end


    context "trying to add a thing already included in user's favorites"do
      before(:each) do
        @favoriter.favorite(@thing)
      end

      it "not include the thing to favorited things" do
        expect(@favoriter.favorited_things.count).to eql(1)
        expect{
          @favoriter.favorite(@thing)
        }.to_not change{ @favoriter.favorited_things.count }.by(1)
      end

  end

  end

end
