defmodule MyApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Accounts.User

  schema "users" do
    field(:email, :string)
    field(:encrypted_password, :string)
    field(:password, :string, virtual: true)
    field(:permissions, :map)

    timestamps()
  end

  @required_fields ~w(email password permissions)
  @optional_fields ~w(encrypted_password)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email, message: "Email already taken")
    |> generate_encrypted_password
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :encrypted_password, Comeonin.Pbkdf2.hashpwsalt(password))

      _ ->
        current_changeset
    end
  end
end
