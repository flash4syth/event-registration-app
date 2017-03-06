defmodule SR.ActivitySpecialNeed do
  use SR.Web, :model

  schema "activities_special_needs" do
    belongs_to :activity, SR.Activity
    belongs_to :special_need_, SR.SpecialNeed

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
