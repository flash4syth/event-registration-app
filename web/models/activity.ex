defmodule SR.Activity do
  use SR.Web, :model

  schema "activities" do
    field :name, :string
    field :start_datetime, Ecto.DateTime
    field :end_datetime, Ecto.DateTime
    field :location, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :start_datetime, :end_datetime, :location, :description])
    |> validate_required([:name, :start_datetime, :end_datetime, :location, :description])
  end
end
