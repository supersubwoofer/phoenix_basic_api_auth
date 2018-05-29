defmodule MyAppWeb.UserControllerTest do
  use MyAppWeb.ConnCase
  import MyApp.Factory
  import MyApp.Accounts.Guardian

  test "GET /api/users/ without permission", %{conn: conn} do
    user = insert(:user)
    {:ok, token, _} = encode_and_sign(user, %{}, permissions: %{default: []})

    conn =
      conn
      |> put_req_header("authorization", "bearer #{token}")
      |> get(user_path(conn, :index))

    assert json_response(conn, 401) == %{"message" => "unauthorized"}
  end

  test "GET /api/users/ renders a list of users", %{conn: conn} do
    user = insert(:user)
    {:ok, token, _} = encode_and_sign(user, %{}, permissions: %{"default" => ["read_users"]})

    conn =
      conn
      |> put_req_header("authorization", "bearer #{token}")
      |> get(user_path(conn, :index))

    assert json_response(conn, 200) == render_json("index.json", users: [user])
  end

  test "GET /api/users/:show without permission", %{conn: conn} do
    user = insert(:user)
    {:ok, token, _} = encode_and_sign(user, %{}, permissions: %{default: []})

    conn =
      conn
      |> put_req_header("authorization", "bearer #{token}")
      |> get(user_path(conn, :show, user.email))

    assert json_response(conn, 401) == %{"message" => "unauthorized"}
  end

  test "GET /api/users/:show renders a single user", %{conn: conn} do
    user = insert(:user)
    {:ok, token, _} = encode_and_sign(user, %{}, permissions: %{"default" => ["read_users"]})

    conn =
      conn
      |> put_req_header("authorization", "bearer #{token}")
      |> get(user_path(conn, :show, user.email))

    assert json_response(conn, 200) == render_json("show.json", user: user)
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    MyAppWeb.UserView.render(template, assigns)
    |> Poison.encode!()
    |> Poison.decode!()
  end
end
