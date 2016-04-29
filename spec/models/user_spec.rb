require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "doesn't allow creating a user with no email" do
      user = User.new(email: nil, password: "asdf", password_confirmation: "asdf")
      user_valid = user.valid?
      expect(user_valid).to eq(false)
    end
    it "doesn't allow creating a user with no password" do
      user = User.new(email: "test@test.com", password: "a", password_confirmation: "a")
      user_valid = user.valid?
      expect(user_valid).to eq(false)
    end
  end
end
