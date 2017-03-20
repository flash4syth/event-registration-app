defmodule SR.MemberActivityTest do
  use SR.ModelCase

  alias SR.MemberActivity

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MemberActivity.changeset(%MemberActivity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MemberActivity.changeset(%MemberActivity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
