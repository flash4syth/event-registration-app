defmodule SR.WardActivity do
  use SR.Web, :model

  schema "wards_activities" do
    belongs_to :ward, SR.Ward
    belongs_to :activity, SR.Activity

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
