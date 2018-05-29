defmodule MyAppWeb.CurrentUserController do
  use MyAppWeb, :controller
  alias MyApp.Accounts
  alias MyApp.Accounts.User
  alias Guardian.Plug

  plug(Guardian.Permissions.Bitwise, ensure: %{default: [:read_users]})

  def index(conn, _params) do
    user = Plug.current_resource(conn)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"user" => user_params}) do
    user = Plug.current_resource(conn)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end
end
