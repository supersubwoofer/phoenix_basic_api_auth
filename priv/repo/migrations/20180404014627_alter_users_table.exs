defmodule MyApp.Repo.Migrations.AlterUsersTable do
  use Ecto.Migration

  def up do
    alter table("users") do
      add :permissions, :map
    end
  end

  def down do
    alter table("users") do
      remove :permissions
    end
  end
end
