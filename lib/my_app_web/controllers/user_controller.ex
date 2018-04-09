defmodule MyAppWeb.UserController do
  use MyAppWeb, :controller
  alias MyApp.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()
    render conn, "index.json", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user_by_id(id)
    render(conn, "show.json", user: user)
  end
end