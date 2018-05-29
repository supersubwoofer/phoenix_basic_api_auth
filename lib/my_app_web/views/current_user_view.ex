defmodule MyAppWeb.CurrentUserView do
  use MyAppWeb, :view

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
