defmodule Tunez.Music.Album do
  use Ash.Resource, otp_app: :tunez, domain: Tunez.Music, data_layer: AshPostgres.DataLayer

  postgres do
    table "albums"
    repo Tunez.Repo

    references do
      reference :artist, index?: true, on_delete: :delete
    end
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:name, :year_released, :cover_image_url, :artist_id]
    end

    update :update do
      accept [:name, :year_released, :cover_image_url]
    end
  end

  validations do
    validate numericality(:year_released,
               greater_than: 1920,
               less_than_or_equal_to: &__MODULE__.next_year/0
             ),
             where: [changing(:year_released)],
             message: "must be a valid year between 1920 and next year"

    validate match(:cover_image_url, ~r"(^https://|/images/|/priv/).+(\.jpg|\.jpeg|\.png)$"),
      where: [changing(:cover_image_url)],
      message: "must start with https:// or /images/ and with .jpg, .jpeg, .png, or .gif"
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
    end

    attribute :year_released, :integer do
      allow_nil? false
      # constraints min: 1900, max: 2100
    end

    attribute :cover_image_url, :string do
      allow_nil? true
      constraints max_length: 2048
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :artist, Tunez.Music.Artist do
      allow_nil? false
    end
  end

  identities do
    identity :unique_albums_for_each_artist,
             [:name, :artist_id],
             message: "An album with this name already exists for this artist"
  end

  def next_year do
    Date.utc_today().year + 1
  end
end
