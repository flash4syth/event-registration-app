defmodule SR.CampTest do
  use SR.ModelCase

  alias SR.Camp

  @moduletag :model_test
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Camp.changeset(%Camp{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Camp.changeset(%Camp{}, @invalid_attrs)
    refute changeset.valid?
  end
end
