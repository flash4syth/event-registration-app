defmodule SR.CabinTest do
  use SR.ModelCase

  alias SR.Cabin

  @moduletag :model_test
  @valid_attrs %{capacity: 42, number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cabin.changeset(%Cabin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cabin.changeset(%Cabin{}, @invalid_attrs)
    refute changeset.valid?
  end
end
