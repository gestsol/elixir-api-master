defmodule ApiMasterWeb.UserView do
  use ApiMasterWeb, :view
  alias ApiMasterWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      is_active: user.is_active,
      name: user.name,
      mobile: user.mobile,
      client_id: user.client_id
    }
  end
end
