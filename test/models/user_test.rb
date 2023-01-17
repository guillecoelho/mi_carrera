require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create_user
  end

  test 'User.from_omniauth of a user that doesn\'t exist, should create a new user' do
    auth = OpenStruct.new(
      provider: 'google',
      uid: '123456789',
      info: OpenStruct.new(
        email: 'user1@gmail.com'
      )
    )

    new_user = User.from_omniauth(auth, {})

    assert new_user.persisted?
    assert_equal new_user.email, auth.info.email
    assert_equal new_user.provider, auth.provider
    assert_equal new_user.uid, auth.uid
  end

  test 'User.from_omniauth of a user that exists, should update the user' do
    auth = OpenStruct.new(
      provider: 'google',
      uid: '123456789',
      info: OpenStruct.new(
        email: @user.email
      )
    )

    existing_user = User.from_omniauth(auth, {})

    assert existing_user.persisted?
    assert_equal existing_user.email, auth.info.email
    assert_equal existing_user.provider, auth.provider
    assert_equal existing_user.uid, auth.uid
  end
end
