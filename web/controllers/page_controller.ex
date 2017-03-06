defmodule SR.PageController do
  use SR.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
