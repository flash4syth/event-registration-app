defmodule SR.Cabin do
  use SR.Web, :model

  schema "cabins" do
    field :number, :string
    field :capacity, :integer
    belongs_to :campsite, SR.Campsite

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:number, :capacity])
    |> validate_required([:number, :capacity])
  end
end
