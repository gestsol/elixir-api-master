defmodule ApiMaster.Repo do
  use Ecto.Repo,
    otp_app: :api_master,
    adapter: Ecto.Adapters.Postgres
end
