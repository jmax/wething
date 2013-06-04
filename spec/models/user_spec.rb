require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"


  it { should validate_uniqueness_of(:email) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }

  it { should ensure_length_of(:password).
              is_at_least(8).
              is_at_most(20) }
  it { should ensure_length_of(:first_name).
              is_at_least(3).
              with_short_message(/not long enough/) }
  it { should ensure_length_of(:last_name).
              is_at_least(3).
              with_short_message(/not long enough/) }

end
