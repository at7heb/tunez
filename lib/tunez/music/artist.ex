defmodule Tunez.Music.Artist do
  use Ash.Resource, otp_app: :tunez, domain: Tunez.Music, data_layer: AshPostgres.DataLayer

  postgres do
    table "artists"
    repo Tunez.Repo
  end

  actions do
    defaults [:create, :read, :destroy]
    default_accept [:name, :biography]

    update :update do
      accept [:name, :biography]
      require_atomic? false

      change Tunez.Music.Changes.UpdatePreviousNames,
        # change fn changeset, _context ->
        #          new_name = Ash.Changeset.get_attribute(changeset, :name) |> dbg
        #          previous_name = Ash.Changeset.get_data(changeset, :name) |> dbg
        #          previous_names = Ash.Changeset.get_data(changeset, :previous_names) |> dbg

        #          names =
        #            [previous_name | previous_names]
        #            |> Enum.uniq()
        #            |> Enum.reject(&(&1 == new_name))

        #          Ash.Changeset.change_attribute(changeset, :previous_names, names)
        #        end,
        where: [changing(:name)]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
      constraints min_length: 1, max_length: 255
    end

    attribute :biography, :string

    attribute :previous_names, {:array, :string} do
      default []
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :albums, Tunez.Music.Album do
      sort year_released: :desc
    end
  end
end
