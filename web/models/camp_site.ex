defmodule SR.CampSite do
  use SR.Web, :model

  schema "camps_sites" do
    field :number, :integer
    belongs_to :camp, SR.Camp

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:number])
    |> validate_required([:number])
  end
end
