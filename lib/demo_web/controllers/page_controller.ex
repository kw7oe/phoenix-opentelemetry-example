defmodule DemoWeb.PageController do
  use DemoWeb, :controller

  def index(conn, _params) do
    Demo.Repo.query!("select current_timestamp;")
    render(conn, "index.html")
  end
end
