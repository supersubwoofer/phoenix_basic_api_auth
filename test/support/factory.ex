defmodule MyApp.Factory do
  use ExMachina.Ecto, repo: MyApp.Repo
  alias MyApp.Accounts.User

  def unencrypted_password do
    "unencrypted_password"
  end
  
  def user_factory do
    %User{
      email: "unique@email",
      encrypted_password: Comeonin.Pbkdf2.hashpwsalt(unencrypted_password),
      password: nil
    }
  end
end