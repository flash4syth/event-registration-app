defmodule SR.AdminMealTest do
  use SR.ModelCase

  alias SR.AdminMeal

  @moduletag :model_test
  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AdminMeal.changeset(%AdminMeal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AdminMeal.changeset(%AdminMeal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
