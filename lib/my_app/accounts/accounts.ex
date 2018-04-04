defmodule MyApp.Accounts do
  alias MyApp.Repo
  alias MyApp.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get!(User, id)
  end

  def get_user_by_email_and_password(nil, _password), do: {:error, :unauthenticated}
  def get_user_by_email_and_password("", _password), do: {:error, :unauthenticated}
  def get_user_by_email_and_password(_email, nil), do: {:error, :unauthenticated}
  def get_user_by_email_and_password(_email, ""), do: {:error, :unauthenticated}

  def get_user_by_email_and_password(email, password) do
    with %User{} = user <- Repo.get_by!(User, email: email),
          true <- Comeonin.Pbkdf2.checkpw(password, user.encrypted_password) do
      {:ok, user}
    else
      _ ->
        # Help to mitigate timing attacks
        Comeonin.Pbkdf2.dummy_checkpw
        {:error, :unauthenticated}
    end
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end