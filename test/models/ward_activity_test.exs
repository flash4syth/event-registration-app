defmodule SR.WardActivityTest do
  use SR.ModelCase

  alias SR.WardActivity

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WardActivity.changeset(%WardActivity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WardActivity.changeset(%WardActivity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
