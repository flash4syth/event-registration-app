defmodule SR.ActivityCampsiteTest do
  use SR.ModelCase

  alias SR.ActivityCampsite

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ActivityCampsite.changeset(%ActivityCampsite{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ActivityCampsite.changeset(%ActivityCampsite{}, @invalid_attrs)
    refute changeset.valid?
  end
end
