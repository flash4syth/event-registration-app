defmodule SR.WardAdmin do
  use SR.Web, :model

  schema "wards_admins" do
    belongs_to :ward, SR.Ward
    belongs_to :admin, SR.Admin

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
