defmodule SR.AdminCabinTest do
  use SR.ModelCase

  alias SR.AdminCabin

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AdminCabin.changeset(%AdminCabin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AdminCabin.changeset(%AdminCabin{}, @invalid_attrs)
    refute changeset.valid?
  end
end
