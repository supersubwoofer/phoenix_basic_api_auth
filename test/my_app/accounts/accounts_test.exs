defmodule MyApp.AccountsTest do
  use MyAppWeb.ConnCase
  import MyApp.Factory
  alias MyApp.Factory.PasswordFactory
  alias MyApp.Accounts

  test "list_users/0" do
    user = insert(:user)
    result = Accounts.list_users

    assert result == [user]
  end

  test "get_user_by_email/1" do
    user = insert(:user)
    result = Accounts.get_user_by_email(user.email)

    assert result == user
  end

  test "get_user_by_email_and_password/2" do
    user = insert(:user)
    result = Accounts.get_user_by_email_and_password(user.email, %PasswordFactory{}.password)

    assert result == {:ok, user}
  end
  
  test "get_user_by_email_and_password/2 with wrong password" do
    user = insert(:user)
    result = Accounts.get_user_by_email_and_password(user.email, %PasswordFactory{}.wrong_password <> "makes it wrong")

    assert result == {:error, :unauthenticated}
  end
    
  test "get_user_by_email_and_password/2 without password" do
    user = insert(:user)
    result = Accounts.get_user_by_email_and_password(user.email, nil)

    assert result == {:error, :unauthenticated}
  end

  test "get_user_by_email_and_password/2 with blank password" do
    user = insert(:user)
    result = Accounts.get_user_by_email_and_password(user.email, "")

    assert result == {:error, :unauthenticated}
  end

  test "get_user_by_email_and_password/2 without email" do
    insert(:user)
    result = Accounts.get_user_by_email_and_password(nil, %PasswordFactory{}.password)

    assert result == {:error, :unauthenticated}
  end

  test "get_user_by_email_and_password/2 with blank email" do
    insert(:user)
    result = Accounts.get_user_by_email_and_password("", %PasswordFactory{}.password)

    assert result == {:error, :unauthenticated}
  end
end