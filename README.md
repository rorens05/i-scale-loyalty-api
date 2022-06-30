# Laurence Bautista Loyalty Platform Assessment for Ruby on Rails

This app development build was deployed in this url: [https://loyalty-platform.rorens.com/](https://loyalty-platform.rorens.com/).

---

## Installation

In terminal, run the following command to clone the repo:

`$ git clone https://github.com/rorens05/i-scale-loyalty-api.git`

## Setup

1. In terminal, cd into the cloned repo:

   `$ cd i-scale-loyalty-api`

1. Then install the dependencies:

   `$ bundle install`

1. Create a .env file from .env.sample:

   `$ cp .env.sample .env`

1. Modify the `.env` to change the database credentials:

   ```
    DB_NAME=loyalty_2
    DB_USER=username
    DB_PASSWORD=password
    DB_HOST=localhost
   ```

1. Save and close `.env`.

1. Create the database and tables:

   `$ bin/rails db:create db:migrate`

1. Start the server:

   `$ bin/rails s`

## Setup (Docker)

1. In terminal, cd into the cloned repo:

   `$ cd i-scale-loyalty-api`

1. Create a .env file from .env.sample:

   `$ cp .env.sample .env`

1. Make sure docker and docker-compose is installed then run:

   `$ sudo docker-compose up`

---

## Usage

Make a POST request to `http://localhost:3000/api/orders` (or in the `https://loyalty-platform.rorens.com/api/orders`) with the following request body:

| Key                   | Value Description |
| ----------------------|-------------------|
| timestamp             | Required.         |
| store_id              | Required          |
| guest_id              | Required          |
| transaction_id        | Required, unique  |
| items                 | Required at least one item   |

Item body

| Key                   | Value Description |
| ----------------------|-------------------|
| sku                   | Required.         |
| price                 | Required.         |
| quantity              | Default 1.        |

### Example Request

POST `http://localhost:3000/api/orders`

Request Body:

```json
{
    "timestamp": "2021-09-21T08:38:12.830Z",
    "store_id": "CADE3B168C", 
    "guest_id": "54D0D284B0",
    "transaction_id": "5AA3C3C7094AF3949EZ",
    "items": [
        {
            "sku": "AAA",
            "price": 1.00,
            "quantity": 1
        },
        {
            "sku": "CCC",
            "price": 2.00,
            "quantity": 1
        }
    ]
}
```

If successful, the response body will be a JSON 

```json
{
  "subtotal": "1.0",
  "discount": "2.0",
  "points": "2.0",
  "message": "Thank you, GuestFirstName, GuestLastName!"
}
```

If not successful, the response body will be a JSON with the list of errors

```json
{
    "order_items.price": [
        "must be greater than 0"
    ],
    "order_items.sku": [
        "can't be blank"
    ],
    "transaction_id": [
        "has already been taken"
    ],
    "store_id": [
        "can't be blank"
    ],
    "guest_id": [
        "can't be blank"
    ],
    "timestamp": [
        "can't be blank"
    ]
}
```