require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end

  setup do
    @user = User.create(email: "tyy@ty.com", password:"hello")
    @post = Post.new(user: @user, title: "Training is back!!!", description: "WE BACK LADDSS!")
    @post.save()
  end

  test "Post must have user title and description" do
    user = User.new(email: "sadge@lmao.com", password: "hello")
    user.save
    bad_post = Post.new(title: "whatup", description: "me no save")
    assert_not bad_post.save

    bad_post = Post.new(user_id: user.id, description: "me no save")
    assert_not bad_post.save

    bad_post = Post.new(user: user, title: "whatup")
    assert_not bad_post.save
  end

  test "Successful post" do
    post = Post.new(user_id: @user.id, title: "Training is back!!!", description: "WE BACK LADDSS!")
    assert post.save
  end

  test "Get Posts" do
    get posts_path, as: :json
    assert_response :ok
  end

  test "show post" do
    get post_path(@post), as: :json
    assert_response :ok
  end

  test "create post path" do
    assert_difference('Post.count') do
      post posts_path, params: { user_id: @user.id, title: "YOYOY", description: "testestest" }, as: :json
    end
    assert_response :created
  end

  test "delete post" do
    assert_difference("Post.count", -1) do
      delete post_path(@post)
    end

  end
end
