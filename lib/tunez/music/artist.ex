defmodule Tunez.Music.Artist do
  use Ash.Resource,
    otp_app: :tunez,
    domain: Tunez.Music,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource, AshJsonApi.Resource]

  graphql do
    type :artist

    filterable_fields [
      :album_count,
      :cover_image_url,
      :latest_album_year_released,
      :inserted_at,
      :updated_at
    ]
  end

  json_api do
    type "artist"
    includes [:albums]
    derive_filter? false
  end

  postgres do
    table "artists"
    repo Tunez.Repo

    custom_indexes do
      index "name gin_trgm_ops", name: "artists_name_trgm_idx", using: "GIN"
    end
  end

  resource do
    description "
      A person or group that creates music.
      Artists can have multiple albums, and their name can change over time.
      The `previous_names` attribute records all the names the artist has had.
      "
  end

  actions do
    defaults [:create, :read, :destroy]
    default_accept [:name, :biography]

    update :update do
      description "Updates an Artist's name and biography, and records the previous names."
      accept [:name, :biography]
      require_atomic? false

      change Tunez.Music.Changes.UpdatePreviousNames,
        where: [changing(:name)]
    end

    read :search do
      argument :query, :ci_string do
        constraints allow_empty?: true
        default ""
        description "Returns only Artists whose names contain this query string"
      end

      filter expr(contains(name, ^arg(:query)))
      pagination offset?: true, default_limit: 8
      description "Lists Artists, optionally allowing a search for Artists by name"
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
      constraints min_length: 1, max_length: 255
      public? true
      description "The name of the artist, which can be a person or a group."
    end

    attribute :biography, :string do
      public? true
      description ""
    end

    attribute :previous_names, {:array, :string} do
      public? true
      default []
    end

    create_timestamp :inserted_at, public?: true
    update_timestamp :updated_at, public?: true
  end

  relationships do
    has_many :albums, Tunez.Music.Album do
      sort year_released: :desc
      public? true
    end
  end

  calculations do
    # calculate :album_count, :integer, expr(count(albums))
    # calculate :latest_album_year_released, :integer, expr(first(albums, field: :year_released))
    # calculate :cover_image_url, :string, expr(first(albums, field: :cover_image_url))
  end

  aggregates do
    count :album_count, :albums do
      public? true
    end

    first :latest_album_year_released, :albums, :year_released do
      public? true
    end

    first :cover_image_url, :albums, :cover_image_url
  end
end
