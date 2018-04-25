# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MyApp.Repo.insert!(%MyApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _user} = MyApp.Accounts.create_user(%{
  email: "admin@somedomain.com",
  password: "qweqweqwe",
  permissions: %{default: [:read_users, :manage_users]}
})

{:ok, _user} = MyApp.Accounts.create_user(%{
  email: "subscriber@somedomain.com",
  password: "qweqweqwe",
  permissions: %{default: [:read_users]}
})

{:ok, _user} = MyApp.Accounts.create_user(%{
  email: "public@somedomain.com",
  password: "qweqweqwe",
  permissions: %{default: []}
})