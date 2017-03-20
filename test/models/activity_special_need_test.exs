defmodule SR.ActivitySpecialNeedTest do
  use SR.ModelCase

  alias SR.ActivitySpecialNeed

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ActivitySpecialNeed.changeset(%ActivitySpecialNeed{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ActivitySpecialNeed.changeset(%ActivitySpecialNeed{}, @invalid_attrs)
    refute changeset.valid?
  end
end
