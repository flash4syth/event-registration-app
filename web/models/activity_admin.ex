defmodule SR.ActivityAdmin do
  use SR.Web, :model

  schema "activities_admins" do
    belongs_to :activity, SR.Activity
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
