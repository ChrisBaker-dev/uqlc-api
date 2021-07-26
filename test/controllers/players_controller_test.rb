require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end

  setup do
    user = User.create(email: "tyty@ty.com", password:"hello")
    @player_1 = Player.new(user: user, name: "Chris", number: "4", position: "Defense", seasons: "12")
    @player_1.save()

    #@bad_player = Player.new(user: user, name: "Chris", number: "4", position: "Defense")
  end

  test "should not save user if user name number position seasons are missing" do
    user = User.create(email: "yada@dada.com", password:"hello")

    player = Player.new()
    assert_not player.save

    player = Player.new(user: user, number: "4", position: "Defense", seasons: "12")
    assert_not player.save

    player = Player.new(user: user, name: "Chris", position: "Defense", seasons: "12")
    assert_not player.save

    player = Player.new(user: user, name: "Chris", number: "4", seasons: "12")
    assert_not player.save

    player = Player.new(user: user, name: "Chris", number: "4", position: "Defense")
    assert_not player.save

    player = Player.new(name: "Chris", number: "4", position: "Defense", seasons: "12")
    assert_not player.save
  end

  test "Player creation" do
    user = User.create(email: "yada@dada.com", password:"hello")
    player = Player.new(user: user, name: "Joey", number: "4", position: "Defense", seasons: "12")
    assert player.save()
  end


  test "Seasons and number should be integers" do
    user = User.create(email: "yada@da.com", password:"hello")
    player = Player.new(user: user, name: "Chris", number: "four", position: "Defense", seasons: "12")
    assert_not player.save

    player = Player.new(user: user, name: "Chris", number: "4", position: "Defense", seasons: "twelve")
    assert_not player.save

    player_3 = Player.new(user: user, name: "Chris", number: "4", position: "Defense", seasons: "8")
    assert player_3.save
  end

  test "should get index" do
    get players_path, as: :json
    assert_response :ok
  end
  
  test "should show player information" do
    get player_path(@player_1), as: :json
    assert_response :ok
  end

  test "Should not show player info" do
    # Not valid player
    get player_path({id: 500})
    assert_response :not_found
  end

  test "Should update player" do
    patch player_url(@player_1),
      params: { player: { name: "Jimbob"} }, as: :json
    #p @player_1.name
    #p @player_1
    assert_response :ok
  end

  test "Should delete player" do
    # p player_url(@player_1)
    assert_difference("Player.count", -1) do
      delete player_path(@player_1)
    end
  end
end
