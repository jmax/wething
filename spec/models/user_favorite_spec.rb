require 'spec_helper'

describe UserFavorite do

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:thing) }
  end

end
