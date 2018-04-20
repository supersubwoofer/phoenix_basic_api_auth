defmodule MyApp.Accounts.Guardian do
    use Guardian, otp_app: :my_app
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
end