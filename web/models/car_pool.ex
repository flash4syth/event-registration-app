defmodule SR.CarPool do
  use SR.Web, :model

  schema "cars_pools" do
    field :departure_time, Ecto.DateTime
    field :destination, :string
    field :capacity, :integer
    field :departure_location, :string
    belongs_to :driver, SR.Driver

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:departure_time, :destination, :capacity, :departure_location])
    |> validate_required([:departure_time, :destination, :capacity, :departure_location])
  end
end
