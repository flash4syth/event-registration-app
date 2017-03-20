defmodule PageTest do
  use ExUnit.Case
  use Hound.Helpers
  use TrueStory

  @moduletag :end2end
  @base_url "http://localhost:4000"

  hound_session()

  test "User can register by first entering provo16stake case insensitively" do
    navigate_to(@base_url)

    login_field = find_element(:css, "#login")

    assert login_field
  end


end
