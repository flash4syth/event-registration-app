defmodule SR.ActivityTest do
  use SR.ModelCase

  alias SR.Activity

  @moduletag :model_test
  @valid_attrs %{description: "some content", end_datetime: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, location: "some content", name: "some content", start_datetime: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Activity.changeset(%Activity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Activity.changeset(%Activity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
