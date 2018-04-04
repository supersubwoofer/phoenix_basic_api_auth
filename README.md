# MyApp

## Descriptions

Phoenix App with basic API authentication and access control [1]

## Steps

1. Authentication and access control
    1. Identify user in system
        1. Fork from repo [Phoenix app - basic User JSON API](https://github.com/supersubwoofer/phoenix_basic_json_api)
        2. Migrate User table with field "permissions: map”
        3. Seed users with different permissions
        4. Write Tests !!! then implement the functions
            1. MyApp.Accounts.list_users/0
            2. MyApp.Accounts.get_user/1
            3. MyApp.Accounts.get_user_by_email_and_password/2
    2. Todo - Authenticate user over HTTP
        1. Add dependences
            1. [Ueberauth](https://github.com/ueberauth/ueberauth) for authentication - use [strategy](https://github.com/ueberauth/ueberauth/wiki/List-of-Strategies) [ueberauth_identity](https://github.com/ueberauth/ueberauth_identity)
            2. [Guardian](https://github.com/ueberauth/guardian) to issue JWT [2]
        2. Create MyApp.Guardian module to issue JWT
        3. Create AuthenticationController
    3. Todo - Authorize resources access credentials
        1. Create Guardian authentication pipline
        2. Apply Guardian.Permissions.Bitwise to control resources access

## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Reference

* [1] Nathan Goddard, (2018) [Ueberauth and guardian setup for a Phoenix rest API](http://blog.nathansplace.co.uk/2018/ueberauth-and-guardian)
* [2] Eric Oestrich, (2016) [Generating a Guardian Secret Key](https://blog.oestrich.org/2016/12/elixir-guardian-secret-key/)

## Reading

* [i] Ed Lima, (2017) [Secure API Access with Amazon Cognito Federated Identities, Amazon Cognito User Pools, and Amazon API Gateway](https://aws.amazon.com/blogs/compute/secure-api-access-with-amazon-cognito-federated-identities-amazon-cognito-user-pools-and-amazon-api-gateway/)
* [ii] Ueberauth docs, (v0.5.0) [Ueberauth API Reference](https://hexdocs.pm/ueberauth/api-reference.html)
* [iii] Guardian docs, (v1.0.1) [Guardian API Reference](https://hexdocs.pm/guardian/api-reference.html)