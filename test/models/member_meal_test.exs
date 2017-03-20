defmodule SR.MemberMealTest do
  use SR.ModelCase

  alias SR.MemberMeal

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MemberMeal.changeset(%MemberMeal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MemberMeal.changeset(%MemberMeal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
