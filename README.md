[![Build Status](https://travis-ci.org/supersubwoofer/phoenix_basic_api_auth.svg?branch=master)](https://travis-ci.org/supersubwoofer/phoenix_basic_api_auth)

# Phoenix Basic API Auth

Phoenix App with basic API authentication and access control [1]

## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Use the API

1. authentication request 
> curl -XPOST \
localhost:4000/api/auth/identity/callback \
-H 'content-type: application/json' \
-d '{"user": {"email": "admin@somedomain.com", "password": "qweqweqwe"}}'

2. response
> {"token":"issued_token"}%

3. users request, copy issued_token from step 2 to authorization header
> curl localhost:4000/api/users \
-H 'content-type: application/json' \
-H 'authorization: bearer issued_token'

## Roadmap

Setup authentication and access control
  
1. Identify user in system
    1. Fork from repo [Phoenix app - basic User JSON API](https://github.com/supersubwoofer/phoenix_basic_json_api)
    2. Migrate User table with field "permissions: map”
    3. Seed users with different permissions
    4. Write Tests !!! then implement the functions
        1. MyApp.Accounts.list_users/0
        2. MyApp.Accounts.get_user/1
        3. MyApp.Accounts.get_user_by_email_and_password/2

2. Authenticate user over HTTP
    1. Add dependences
        1. [Ueberauth](https://github.com/ueberauth/ueberauth) for authentication - use [strategy](https://github.com/ueberauth/ueberauth/wiki/List-of-Strategies) [ueberauth_identity](https://github.com/ueberauth/ueberauth_identity)
        2. [Guardian](https://github.com/ueberauth/guardian) to issue JWT [2]
    2. Create MyApp.Guardian module to issue JWT
    3. Create endpoint /api/auth/identity/callback and AuthenticationController
    4. Write tests for the endpoint
    5. Create Guardian authentication pipline to check valid authication token exist in request header 

3. Authorize resources access credentials
    1. Apply Guardian.Permissions.Bitwise to control resources access
    2. Rewrite Old tests. Old tests do not work after access control

## Reference

* [1] Nathan Goddard, (2018) [Ueberauth and guardian setup for a Phoenix rest API](http://blog.nathansplace.co.uk/2018/ueberauth-and-guardian)
* [2] Eric Oestrich, (2016) [Generating a Guardian Secret Key](https://blog.oestrich.org/2016/12/elixir-guardian-secret-key/)

## Reading

* [i] Ed Lima, (2017) [Secure API Access with Amazon Cognito Federated Identities, Amazon Cognito User Pools, and Amazon API Gateway](https://aws.amazon.com/blogs/compute/secure-api-access-with-amazon-cognito-federated-identities-amazon-cognito-user-pools-and-amazon-api-gateway/)
* [ii] Ueberauth docs, (v0.5.0) [Ueberauth API Reference](https://hexdocs.pm/ueberauth/api-reference.html)
* [iii] Guardian docs, (v1.0.1) [Guardian API Reference](https://hexdocs.pm/guardian/api-reference.html)