defmodule SR.MealItem do
  use SR.Web, :model

  schema "meals_items" do
    field :description, :string
    field :cost, :float
    field :store_origin, :string
    belongs_to :meal, SR.Meal
    belongs_to :admin, SR.Admin

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :cost, :store_origin])
    |> validate_required([:description, :cost, :store_origin])
  end
end
