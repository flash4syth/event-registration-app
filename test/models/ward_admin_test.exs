defmodule SR.WardAdminTest do
  use SR.ModelCase

  alias SR.WardAdmin

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WardAdmin.changeset(%WardAdmin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WardAdmin.changeset(%WardAdmin{}, @invalid_attrs)
    refute changeset.valid?
  end
end
