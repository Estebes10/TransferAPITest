# README

This README would normally document whatever steps are necessary to get the
application up and running.

Project specifications:

* Ruby version
  - 2.5.1
* Rails version
  - 5.2.2
* libraries used
  - Httpie (command line HTTP client)

  * System dependencies
    * rspec-rails - Testing framework.
    * factory_bot_rails - Helpers constructors for testing
    * shoulda_matchers - Additional matchers for Rspec
    * database_cleaner - Gem to clean the test database
    * faker - Library for generating fake data.
    * postgresql - Database Manager System


* Database creation
  * Prepare database
  ```shell
    rails db:create
  ```

* Database initialization
  * Migrate and initialize seeds
  ```shell
    rails db:migrate
    rails db:seed
  ```

## Run tests
* How to run the test suite
  ```shell
    bundle exec rspec spec/ -fd
  ```

## Endpoints used

### POST /auth/login
Authenticate an user from the db

**Params**
email -> Email of Previous user registered
password -> Password of Previous user registered

Example using httpie:
```shell
  http POST :3000/auth/login email=USER_EMAIL_HERE password=CONTRASENA_HERE
```

Response:
```shell
{
    "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Njg2NDMzMTF9.Z3HZ9icj2wARUjzqBi-ZtQj8mtEqCmq-kMsqLfs-jzM"
}
```

### GET /api/v1/users/:id
Get an specficic user from the db, only 'ADMIN'

**Params**
Hidden token -> Token of Previous user registered and logged in (ADMIN)<br/>

Example using httpie:
```shell
  http GET :3000/api/v1/users/4 Authorization:'TOKEN HERE'
```

Response:
```shell
{
    "account": {
        "balance": "10739.12",
        "clabe": "0878817080084143",
        "created_at": "2019-09-15T06:55:33.828Z",
        "id": 1,
        "updated_at": "2019-09-15T13:50:50.687Z",
        "user_id": 4
    },
    "user": {
        "created_at": "2019-09-15T06:55:33.813Z",
        "email": "juan22@example.com",
        "id": 4,
        "name": "JuanC2",
        "password_digest": "$2a$10$NsN7hOfa.jigu42K0.VzgObxVOG7SwNWcemZ.6Qb70fuDLcgPWhdy",
        "role_id": 2,
        "updated_at": "2019-09-15T06:55:33.813Z"
    }
}
```

### POST /api/v1/register_user
Register a new user in the db, only 'ADMIN'

**Params**
Authorization -> HEADER Token of Previous user registered and logged in (ADMIN)<br/>
email         -> Email for new user<br/>
password      -> Password for new user<br/>
name          -> Name for new user<br/>
role          -> Role for new user (1. ADMIN, 2. HOLDER)<br/>

Example using httpie:
```shell
  http POST :3000/api/v1/register_user name=USER_NAME_HERE email=USER_EMAIL_HERE password=CONTRASENA_HERE Authorization:'TOKEN HERE' role_id=2
```

Response:
```shell
{
    "message": "Great, the User was created successfully",
    "user": {
        "created_at": "2019-09-15T14:22:48.448Z",
        "email": "maria@example.com",
        "id": 6,
        "name": "Maria",
        "password_digest": "$2a$10$l2199al5onBoGPI1l65E.ubAtuOtQVsS1Y3q5/.IiTuQV6StG6YsS",
        "role_id": 2,
        "updated_at": "2019-09-15T14:22:48.448Z"
    }
}
```

### POST /api/v1/deliver_money
Deposit a certain amount of money to specific holder, only 'ADMIN'

**Params**
Authorization   -> HEADER Token of Previous user registered and logged in (ADMIN)<br/>
holder_account  -> ACCOUNT of some holder<br/>
amount          -> AMOUNT of some holder<br/>


Example using httpie:
```shell
  http POST :3000/api/v1/deliver_money holder_account=HOLDER_ACCOUNT_HERE amount=AMOUNT_HERE Authorization:'TOKEN HERE'
```

Response:
```shell
{
    "message": "Successfull transaction"
}
```

### POST /api/v1/transfer
Make transactions to other holder, only 'HOLDER'. Transactions are made just when user is holder,
destination clabe belongs to another holder and AMOUNT is less than current holder balance.

**Params**
Authorization        -> HEADER Token of Previous user registered and logged in (HOLDER)<br/>
destination_account  -> ACCOUNT of another holder<br/>
amount               -> AMOUNT of another holder<br/>

Example using httpie:
```shell
  http POST :3000/api/v1/transfer destination_account=CLABE_HERE amount=AMOUNT_HERE Authorization:'TOKEN HERE'
```

Response:
```shell
{
    "amount": 25005.0,
    "destination": "8860731437064301",
    "message": "Successfull transaction"
}
```

### GET  /api/v1/transactions
Get previous transactions of current holder, only 'HOLDER'

**Params**
Authorization        -> HEADER Token of Previous user registered and logged in (HOLDER)<br/>

Example using httpie:
```shell
  http GET :3000/api/v1/transactions Authorization:'TOKEN HERE'
```

Response (list of previous transactions):
```shell
[
    {
        "amount": "25005.0",
        "created_at": "2019-09-15T14:33:57.610Z",
        "destination_account": "8860731437064301",
        "id": 6,
        "source_account": "4680342499758648",
        "updated_at": "2019-09-15T14:33:57.610Z"
    }
]
```


### Bad requests

When some ADMIN tries to tranfer more money.
```shell
{
    "message": "The user: NAME, has not privileges to make transactions, it must be holder"
}
```

When some holder tries to tranfer more money than it currently has.
```shell
{
    "message": "The holder has no enough money"
}
```

When some holder tries to make some ADMIN activites (ej. create users)
```shell
{
    "message": "The USER has not permission to create users"
}
```

## Database architecture

**USER table**

Attributes | Name | Email | Password | Role_id
--- | --- | --- | --- |--- | --- | ---
required | true | true  | true | true
length  | String of 64 | String of 64  | String of 64 | integer of 32    
description | User name | User email | user password  | role id

**ROLE table**

Attributes | Name | Code
--- | --- | --- | ---
required | true | true
length  | String of 64 | String of 32    
description | Role name | Unique code for role

**ACCOUNT table**

Attributes | Balance | Clabe | User_id
--- | --- | --- | --- |--- | --- | ---
required | true | true  | true
length  | string of 64 | String of 16  | Integer of 32
description | Balance of holder | Unique public clabe | user id associated to the account

**TRANSFER table**

Attributes | Source account | Destination account | amount
--- | --- | --- | --- |---
required | true | true  | true
length  | String of 16 | String of 16 | 10 decimal   
description | Cable of current holder| Clabe of destination holder| Amount of money to transfer

# TransferAPITest
