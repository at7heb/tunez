# Tunez

The starter app for the upcoming [Ash Framework](https://pragprog.com/titles/ldash/ash-framework/) book.

## Setup

The versions of Elixir and Erlang we're using are specified in the `.tool-versions` file. If you're using `asdf` to manage installed versions of languages, run `asdf install` to install them. Tunez should work with any reasonably recent versions, but newer is better!

Once you have those installed:

* Run `mix setup` to install and setup Elixir dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Debugging

``` zsh
to get to the database, use this command: "psql -U elixir -d postgres"
\l to list databases
\c <database>
\dt to list relations/tables
drop table first_table;
drop table second_table;
```

if you drop the schema_migrations and other tables,
you can request the migrations again
what does "mix ash.reset" do?
what does "mix ash.setup" do?
