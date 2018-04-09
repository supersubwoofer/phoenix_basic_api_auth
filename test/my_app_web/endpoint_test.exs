defmodule MyAppWeb.EndpointTest do
  use MyAppWeb.ConnCase
  import MyApp.Factory
  alias MyApp.Factory.PasswordFactory
  
  test "#index renders a list of users" do
    user = insert(:user)
    conn = post build_conn(), "/api/auth/identity/callback", [email: user.email, password: %PasswordFactory{}.password]

    assert json_response(conn, 200) =~ "%{token: token}"
  end
end