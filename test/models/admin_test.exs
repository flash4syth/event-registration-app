defmodule SR.AdminTest do
  use SR.ModelCase

  alias SR.Admin

  @moduletag :model_test
  @valid_attrs %{is_superadmin: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Admin.changeset(%Admin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Admin.changeset(%Admin{}, @invalid_attrs)
    refute changeset.valid?
  end
end
