defmodule SR.SpecialNeedTest do
  use SR.ModelCase

  alias SR.SpecialNeed

  @moduletag :model_test
  @valid_attrs %{description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SpecialNeed.changeset(%SpecialNeed{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SpecialNeed.changeset(%SpecialNeed{}, @invalid_attrs)
    refute changeset.valid?
  end
end
