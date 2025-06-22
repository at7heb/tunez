defmodule Tunez.Music.Artist do
  use Ash.Resource, otp_app: :tunez, domain: Tunez.Music, data_layer: AshPostgres.DataLayer

  postgres do
    table "artists"
    repo Tunez.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string do
      allow_nil? false
      constraints min_length: 1, max_length: 255
    end
    attribute :biography, :string

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

end
