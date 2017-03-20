defmodule SR.RegistrationTest do
  use SR.ModelCase

  alias SR.Registration

  @moduletag :model_test
  @valid_attrs %{confirmed?: true, type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Registration.changeset(%Registration{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Registration.changeset(%Registration{}, @invalid_attrs)
    refute changeset.valid?
  end
end
