defmodule SR.WardTest do
  use SR.ModelCase

  alias SR.Ward

  @moduletag :model_test
  @valid_attrs %{bishop_last_name: "some content", member_count: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ward.changeset(%Ward{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ward.changeset(%Ward{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "create ward" do
    %Ward{} |> Repo.insert!()

    ward = Repo.all(Ward)
    IO.inspect(ward)
  end
end
