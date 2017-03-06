defmodule SR.MemberMeal do
  use SR.Web, :model

  schema "members_meals" do
    belongs_to :member, SR.Member
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
