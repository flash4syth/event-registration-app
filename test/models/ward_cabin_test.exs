defmodule SR.WardCabinTest do
  use SR.ModelCase

  alias SR.WardCabin

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WardCabin.changeset(%WardCabin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WardCabin.changeset(%WardCabin{}, @invalid_attrs)
    refute changeset.valid?
  end
end
