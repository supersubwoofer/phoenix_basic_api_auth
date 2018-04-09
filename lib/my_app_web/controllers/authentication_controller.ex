  defmodule MyAppWeb.AuthenticationController do
    use MyAppWeb, :controller

    alias MyApp.Accounts

    plug Ueberauth

    def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
      unique_email = auth.uid
      password = auth.credentials.other.password
      handle_user_conn(Accounts.get_user_by_email_and_password(unique_email, password), conn)
    end

    defp handle_user_conn(user, conn) do
      case user do
        {:ok, user} ->
          {:ok, jwt, _full_claims} = 
          Accounts.Guardian.encode_and_sign(user, %{})
          # {:ok, "debug_jwt", "debug_claims"}

          conn
          |> put_resp_header("authorization", "Bearer #{jwt}")
          |> json(%{token: jwt})

        # Handle our own error to keep it generic
        {:error, _reason} ->
          conn
          |> put_status(401)
          |> json(%{message: "user not found"})
      end
    end
  end