defmodule MyAppWeb.UserView do
  use MyAppWeb, :view

  def render("index.json", %{users: users}) do
    %{
      users: Enum.map(users, &user_json/1)
    }
  end

  def render("show.json", %{user: user}) do
    %{user: user_json(user)}
  end

  def user_json(user) do
    %{
      email: user.email,
      encrypted_password: user.encrypted_password,
      permissions: user.permissions
    }
  end
end
