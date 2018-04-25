defmodule MyAppWeb.UserControllerTest do
  use MyAppWeb.ConnCase
  import MyApp.Factory
  
  test "#index renders a list of users" do
    user = insert(:user)
    conn = build_conn()
    conn = get conn, user_path(conn, :index)

    assert json_response(conn, 200) == render_json("index.json", users: [user])
  end

  test "#show renders a single user" do
    user = insert(:user)
    conn = build_conn()
    conn = get conn, user_path(conn, :show, user.email)

    assert json_response(conn, 200) == render_json("show.json", user: user)
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    MyAppWeb.UserView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end