defmodule MyApp.AccountsTest do
  use MyAppWeb.ConnCase
  import MyApp.Factory
  alias MyApp.Accounts

  test "list_users/0" do
    user = insert(:user)
    queried_users = Accounts.list_users

    assert queried_users == [user]
  end

  test "get_user/1" do
    user = insert(:user)
    queried_user = Accounts.get_user(user.id)

    assert queried_user == user
  end

  test "get_user_by_email_and_password/2" do
    user = insert(:user)
    queried_user = Accounts.get_user_by_email_and_password(user.email, unencrypted_password())

    assert queried_user == user
  end
end