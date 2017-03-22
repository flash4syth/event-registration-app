defmodule PageTest do
  use ExUnit.Case, async: true
  use Hound.Helpers

  @moduletag :end2end
  @base_url "http://localhost:4000"

  hound_session()

  test "User login and registration for Stake Retreat" do

    # login field exists
    navigate_to(@base_url)
    login_field = find_element(:css, "#login")

    assert login_field

    # submitting bad password shows login error message
    change_session_to :other_user
    navigate_to(@base_url)
    login_field2 = find_element(:css, "#login")

    fill_field(login_field2, "wrong_pass")

    refute inner_text({:css, "h1"}) == "Register"
    assert inner_text({:css, "#error-message"}) == "That password is incorrect."

    # submitting the correct password 'provo16stake' takes the user
    # to the registration page
    change_to_default_session()

    fill_field(login_field, "provo16stake")
    click({:css, "button"})

    assert inner_text({:css, "h1"}) == "Registration"

    # the password is case insensitive
    change_session_to :other_user

    fill_field(login_field2, "Provo16STAKE")
    click({:css, "button"})

    assert inner_text({:css, "h1"}) == "Registration"
  end

end
