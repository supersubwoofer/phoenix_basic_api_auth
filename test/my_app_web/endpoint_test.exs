defmodule MyAppWeb.EndpointTest do
  use MyAppWeb.ConnCase
  import MyApp.Factory
  alias MyApp.Factory.PasswordFactory
  
  test "#identify a user and response with a jwt token" do
    user = insert(:user)
    conn = build_conn()
            |> put_req_header("content-type", "application/json")
            |> post(
              "/api/auth/identity/callback",
              "{\"user\": {\"email\": \"#{user.email}\", \"password\": \"#{%PasswordFactory{}.password}\"}}"
              )

    resp_map = json_response(conn, 200)
    assert resp_map["token"] != nil
  end

  test "#reject an identity request with wrong password" do
    user = insert(:user)
    conn = build_conn()
            |> put_req_header("content-type", "application/json")
            |> post(
              "/api/auth/identity/callback",
              "{\"user\": {\"email\": \"#{user.email}\", \"password\": \"#{%PasswordFactory{}.wrong_password}\"}}"
              )

    assert json_response(conn, 401) == %{"message" => "unidentified"}
  end

  test "#reject an identity request without password" do
    user = insert(:user)
    conn = build_conn()
            |> put_req_header("content-type", "application/json")
            |> post(
              "/api/auth/identity/callback",
              "{\"user\": {\"email\": \"#{user.email}\"}}"
              )

    assert json_response(conn, 401) == %{"message" => "unidentified"}
  end

  test "#reject an identity request without email and password" do
    _user = insert(:user)
    conn = build_conn()
            |> put_req_header("content-type", "application/json")
            |> post(
              "/api/auth/identity/callback"
              )

    assert json_response(conn, 401) == %{"message" => "unidentified"}
  end
end