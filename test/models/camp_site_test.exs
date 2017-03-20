defmodule SR.CampSiteTest do
  use SR.ModelCase

  alias SR.CampSite

  @moduletag :model_test
  @valid_attrs %{number: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CampSite.changeset(%CampSite{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CampSite.changeset(%CampSite{}, @invalid_attrs)
    refute changeset.valid?
  end
end
