defmodule SR.AdminMeal do
  use SR.Web, :model

  schema "admins_meals" do
    belongs_to :admin, SR.Admin
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
