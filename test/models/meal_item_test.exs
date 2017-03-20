defmodule SR.MealItemTest do
  use SR.ModelCase

  alias SR.MealItem

  @moduletag :model_test
  @valid_attrs %{cost: "120.5", description: "some content", store_origin: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MealItem.changeset(%MealItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MealItem.changeset(%MealItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
