defmodule MyApp.Factory do
  use ExMachina.Ecto, repo: MyApp.Repo
  alias MyApp.Accounts.User

  defmodule PasswordFactory do
    defstruct password: "unencrypted_password", 
    encrypted_password: Comeonin.Pbkdf2.hashpwsalt("unencrypted_password"), 
    wrong_password: "wrong_password"
  end

  def user_factory do
    %User{
      email: "unique@email",
      encrypted_password: %PasswordFactory{}.encrypted_password,
      permissions: %{"default" => ["read_users", "manage_users"]}
    }
  end
end