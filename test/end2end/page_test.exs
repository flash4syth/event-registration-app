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

    # submitting bad password shows login error message rather than
    # the registration page
    fill_field(login_field, "wrong_pass")
    click({:css, "button"})

    refute inner_text({:css, "h1"}) == "Register"
    assert inner_text({:css, "#error-message"}) == "That password is incorrect."

    # submitting the correct password 'provo16stake' takes the user
    # to the registration page, the password is case insensitive
    fill_field(login_field, "Provo16STAKE")
    click({:css, "button"})

    assert inner_text({:css, "h1"}) == "Registration"


    # Fill out and submit registration form
    fill_field({:css, "#first-name"})
    fill_field({:css, "#second-name"})
    fill_field({:css, "#email"})
    fill_field({:css, "#phone-number"})
    fill_field({:css, "ward"})
  end

end
