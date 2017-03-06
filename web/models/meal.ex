defmodule SR.Meal do
  use SR.Web, :model

  schema "meals" do
    field :name, :string
    field :time, :time
    field :location, :string, default: nil
    many_to_many :members, SR.Member, join_through: "members_meals"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    # |> validate_required([])
    |> validate_required([:name])
  end
end
