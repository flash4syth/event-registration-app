defmodule SR.MealTest do
  use SR.ModelCase

  alias SR.Meal
  import SR.Factory

  @moduletag :model_test
  @valid_attrs %{name: "Breakfast", location: "A"}
  # @valid_attrs %{name: "Breakfast", time: ~T[01:00:00.001], location: "A"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Meal.changeset(build(:meal), @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Meal.changeset(%Meal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
