defmodule SR.Activity do
  use SR.Web, :model

  schema "activities" do
    field :name, :string
    field :start_datetime, Ecto.DateTime
    field :stringtime, :string
    field :end_datetime, Ecto.DateTime
    field :location, :string
    field :description, :string
    field :blurb, :string
    field :image, :string

    many_to_many :members, SR.Member, join_through: "members_activities"
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :start_datetime, :stringtime, :end_datetime,
      :location, :description, :blurb])
    |> validate_required([:name, :stringtime, :location, :description, :blurb])

  end
end
