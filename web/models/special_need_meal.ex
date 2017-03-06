defmodule SR.SpecialNeedMeal do
  use SR.Web, :model

  schema "specials_needs_meals" do
    belongs_to :special_need_, SR.SpecialNeed
    belongs_to :meal, SR.Meal

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
