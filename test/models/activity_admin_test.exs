defmodule SR.ActivityAdminTest do
  use SR.ModelCase
  
  alias SR.ActivityAdmin

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ActivityAdmin.changeset(%ActivityAdmin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ActivityAdmin.changeset(%ActivityAdmin{}, @invalid_attrs)
    refute changeset.valid?
  end
end
