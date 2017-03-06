defmodule SR.AdminCabin do
  use SR.Web, :model

  schema "admins_cabins" do
    belongs_to :admin, SR.Admin
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
