defmodule SR.CarPoolTest do
  use SR.ModelCase

  alias SR.CarPool

  @moduletag :model_test
  @valid_attrs %{capacity: 42, departure_location: "some content", departure_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, destination: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CarPool.changeset(%CarPool{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CarPool.changeset(%CarPool{}, @invalid_attrs)
    refute changeset.valid?
  end
end
