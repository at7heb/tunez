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

## Authentication and Authorization

### Roles

To build roles, create an organization resource.
Try to understand this:

<https://elixirforum.com/t/how-to-use-ash-policies-when-users-have-a-different-role-for-each-organization/69801>

Query to Google: ```ash framework attribute is a list, set, or array```

Response from Google

``` text
In the Ash Framework for Elixir, attributes can be defined as arrays of a specific type. This allows you to store a list of values within a single column of your resource. 
For example, to define an attribute named allowed_roles as an array of the Tunez.Accounts.Role enum, you would use the following syntax: attribute :allowed_roles, {:array, Tunez.Accounts.Role}. 
While Ash doesn't have a direct equivalent to "sets" in the mathematical sense (where elements are unordered and unique), you can achieve similar functionality using arrays and potentially custom validations or unique indexes if needed. 
It's important to note that while the Ash Hexdocs might contain references to a "vector type", the primary way to define a list-like attribute in Ash is by using the {:array, } syntax. 
```
