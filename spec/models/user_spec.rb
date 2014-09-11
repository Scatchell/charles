require 'rails_helper'

RSpec.describe User, :type => :model do

  it 'should generate random auth code after createion' do
    create(:user)

    User.last.auth_code.should_not be_empty
  end
end
