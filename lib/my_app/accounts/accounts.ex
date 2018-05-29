defmodule MyApp.Accounts do
  alias MyApp.Repo
  alias MyApp.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user_by_email(email) do
    Repo.get_by!(User, email: email)
  end

  def get_user_by_email_and_password(nil, _password), do: {:error, :unauthenticated}
  def get_user_by_email_and_password("", _password), do: {:error, :unauthenticated}
  def get_user_by_email_and_password(_email, nil), do: {:error, :unauthenticated}
  def get_user_by_email_and_password(_email, ""), do: {:error, :unauthenticated}

  def get_user_by_email_and_password(email, password) do
    with %User{} = user <- get_user_by_email(email),
         true <- Comeonin.Pbkdf2.checkpw(password, user.encrypted_password) do
      {:ok, user}
    else
      _ ->
        # Help to mitigate timing attacks
        Comeonin.Pbkdf2.dummy_checkpw()
        {:error, :unauthenticated}
    end
  end

  def create_user(user_params \\ %{}) do
    %User{}
    |> User.changeset(user_params)
    |> Repo.insert()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def update_user(%User{} = user, user_params) do
    user
    |> User.changeset(user_params)
    |> Repo.update()
  end
end
