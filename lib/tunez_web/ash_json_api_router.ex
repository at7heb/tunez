defmodule TunezWeb.AshJsonApiRouter do
  use AshJsonApi.Router,
    domains: [Tunez.Music, Tunez.Accounts],
    open_api: "/open_api",
    open_api_title: "TuneZ Music API Documentation",
    open_api_version: Application.spec(:tunez, :vsn) |> to_string()
end
