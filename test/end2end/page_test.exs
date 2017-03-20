defmodule PageTest do
  use ExUnit.Case
  use Hound.Helpers
  use TrueStory

  @moduletag :end2end
  @base_url "http://localhost:4000"

  hound_session()

  test("User browses to /, sees text field, enters 'provo16stake' and " <>
      "clicks enter, then is taken to registration page") do
    navigate_to(@base_url)
    login_field = find_element(:css, "#login")

    assert login_field

    fill_field(login_field, "provo16stake")
    click({:css, "button"})

    assert inner_text({:css, "h1"}) == "Registration"
  end

  test("User browses to /, enters wrong password 'wrong_pass', and is not " <>
      "taken to the registration page, but shown a login error message") do
    navigate_to(@base_url)
    fill_field({:css, "#login"}, "wrong_pass")

    refute inner_text({:css, "h1"}) == "Register"
    assert inner_text({:css, "#message"}) == "That password is incorrect."

  end

  test "User can register by entering in Provo16STAKE (case insensitively)" do
    navigate_to(@base_url)

    login_field = find_element(:css, "#login")
    fill_field(login_field, "Provo16STAKE")

    assert login_field
  end

end
