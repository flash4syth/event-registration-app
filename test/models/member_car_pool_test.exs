defmodule SR.MemberCarPoolTest do
  use SR.ModelCase

  alias SR.MemberCarPool

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MemberCarPool.changeset(%MemberCarPool{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MemberCarPool.changeset(%MemberCarPool{}, @invalid_attrs)
    refute changeset.valid?
  end
end
