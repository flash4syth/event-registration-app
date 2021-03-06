defmodule SR.MemberTest do
  use SR.ModelCase

  alias SR.Member
  import SR.Factory

  @moduletag :model_test
  @valid_attrs %{age: 42,
    email: "some content",
    first_name: "some content",
    gender: "some content",
    last_name: "some content",
    phone: "some content"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Member.changeset(build(:member), @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Member.changeset(%Member{}, @invalid_attrs)
    refute changeset.valid?
  end
end
