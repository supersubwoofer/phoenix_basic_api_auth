defmodule MyApp.Accounts.Guardian do
  use Guardian, otp_app: :my_app
  use Guardian.Permissions.Bitwise
  alias MyApp.Accounts

  def subject_for_token(%{email: email}, _claims) do
    {:ok, to_string(email)}
  end

  def subject_for_token(_, _) do
    {:error, :no_resource_sub}
  end

  def resource_from_claims(%{"sub" => sub}) do
    {:ok, Accounts.get_user_by_email(sub)}
  end

  def resource_from_claims(_claims) do
    {:error, :no_claims_sub}
  end

  def build_claims(claims, _resource, opts) do
    claims =
      claims
      |> encode_permissions_into_claims!(Keyword.get(opts, :permissions))

    {:ok, claims}
  end
end
