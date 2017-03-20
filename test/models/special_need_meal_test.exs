defmodule SR.SpecialNeedMealTest do
  use SR.ModelCase

  alias SR.SpecialNeedMeal

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SpecialNeedMeal.changeset(%SpecialNeedMeal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SpecialNeedMeal.changeset(%SpecialNeedMeal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
