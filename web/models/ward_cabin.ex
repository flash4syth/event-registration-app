defmodule SR.WardCabin do
  use SR.Web, :model

  schema "wards_cabins" do
    belongs_to :ward, SR.Ward
    belongs_to :cabin, SR.Cabin

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
