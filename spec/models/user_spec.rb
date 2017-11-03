require 'rails_helper'

describe User do

  it "has a valid factory" do
    expect(build(:user)).to be_valid  
  end

  it "is valid with a username" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid with duplicate username" do
    user1 = create(:user, username: 'umar')
    user2 = build(:user, username: 'umar')
    user2.valid?
    expect(user2.errors[:username]).to include("has already been taken")
  end

  context "on a new user" do
    it "is invalid without a password" do
      user = build(:user, password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with less than 8 characters password" do
      user = build(:user, password: '12345')
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

    it "is invalid with a confirmation missmatch" do
      user = build(:user, password: '123456789', password_confirmation: '1234567899')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  context "on existing user" do
    before :each do
      @user = create(:user)
    end

    it "is valid with no changes" do
      expect(@user.valid?).to eq(true)
    end

    it "is invalid with an empty password" do
      @user.password_digest = ''
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it "is valid with a new (valid) password" do
      @user.password = '123456789'
      @user.password_confirmation = '123456789'
      expect(@user.valid?).to eq(true)
    end
  end

end