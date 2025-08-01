defmodule Tunez.Repo.Migrations.AddPreviousArtistsNames do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    alter table(:artists) do
      add :previous_names, {:array, :text}, default: []
    end
  end

  def down do
    alter table(:artists) do
      remove :previous_names
    end
  end
end
