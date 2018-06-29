defmodule YaetaWeb.PageController do
  use YaetaWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
