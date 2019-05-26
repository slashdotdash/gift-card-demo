# Getting started with Commanded

This Commanded demo application focuses around a simple giftcard domain, designed to show how to configure and use the library.

It is heavily inspired by the [Axon Framework demo application](https://github.com/AxonIQ/giftcard-demo/).

## Domain model

There are just two events in the lifecycle of a gift card:

1. Issued: a new gift card gets created with some amount of money stored.
2. Redeemed: all or part of the monetary value stored on the gift card is used to purchase something.

## Running the demo

Requires Elixir 1.8 or later and a Postgres 9.5 or later database.

1. Clone the git repo:

    ```console
    git clone https://github.com/slashdotdash/gift-card-demo.git
    ```

3. Get mix dependencies:

    ```console
    mix deps.get
    ```

3. Create and initialise the database:

    ```console
    mix setup
    ```

4. Run Phoenix server:

    ```console
    iex -S mix phx.server
    ```

### Database

In this demo the write (event store) and read (projections) models share the same database (named `giftcard_<env>`). In a production environment you might choose to configure and use two separate databases, one for each model.
