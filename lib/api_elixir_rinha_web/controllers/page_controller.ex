defmodule ApiElixirRinhaWeb.PageController do
  use ApiElixirRinhaWeb, :controller

  def home(conn, _params) do
    conn
    |> put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "Hello World")
  end
end