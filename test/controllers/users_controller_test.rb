require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end

  test "should not save user if username and email missing" do
    user = User.new() 
    assert_not user.save

    user = User.new(email: "foo@bar.com")
    assert_not user.save

    user = User.new(password: "hello")
    assert_not user.save

    user = User.new(email: "foo@bar.com", password: "hello")
    assert user.save
  end

  



  

end
