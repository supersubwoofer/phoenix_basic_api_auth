defmodule MyAppWeb.UserController do
  use MyAppWeb, :controller
  alias MyApp.Accounts
  alias MyApp.Accounts.User
  
  plug Guardian.Permissions.Bitwise, ensure: %{default: [:read_users]}
  plug Guardian.Permissions.Bitwise, [ensure: %{default: [:manage_users]}] when action in [:create, :update, :delete]

  def index(conn, _params) do
    users = Accounts.list_users()
    render conn, "index.json", users: users
  end

  def show(conn, %{"id" => email}) do
    user = Accounts.get_user_by_email(email)
    render conn, "show.json", user: user
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def update(conn, %{"id" => email, "user" => user_params}) do
    user = Accounts.get_user_by_email(email)
    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => email}) do
    user = Accounts.get_user_by_email(email)
    with {:ok, %User{} = user} <- Accounts.delete_user(user) do
      render(conn, "show.json", user: user)
    end
  end
end