defmodule SR.PageControllerTest do
  use SR.ConnCase

  @moduletag :controller_test

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Stake Retreat"
  end
end
