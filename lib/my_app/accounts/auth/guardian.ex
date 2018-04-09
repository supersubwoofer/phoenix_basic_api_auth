defmodule MyApp.Accounts.Guardian do
    use Guardian, otp_app: :my_app
    alias MyApp.Accounts

    def subject_for_token(%{id: id}, _claims) do
      {:ok, to_string(id)}
    end

    def subject_for_token(_, _) do
      {:error, :no_resource_id}
    end

    def resource_from_claims(%{"sub" => sub}) do
      {:ok, Accounts.get_user_by_id(sub)}
    end

    def resource_from_claims(_claims) do
      {:error, :no_claims_sub}
    end
end