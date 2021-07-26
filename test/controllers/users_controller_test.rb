require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end
  setup do
    @user = User.create(email: "tyty@ty.com", password:"hello")
    @user.save
  end

  test "should not save user if username and email missing" do
    user = User.new() 
    assert_not user.save

    user = User.new(email: "foo@bar.com")
    assert_not user.save

    user = User.new(password: "hello")
    assert_not user.save
  end

  test "Should create a user" do
    user = User.new(email: "foo@bar.com", password: "hello")
    assert user.save
  end

  test "Login Path" do
    post login_path, params: { email: @user.email, password: @user.password }
    assert_response :ok
  end

  test "register path" do
    post register_path, params: {email: "yoink@whatt.com", password: "hello"}
    assert_response :created
  end

end
