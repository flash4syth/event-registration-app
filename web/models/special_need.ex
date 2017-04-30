defmodule SR.SpecialNeed do
  use SR.Web, :model

  schema "special_needs" do
    field :description, :string
    field :wheelchair, :boolean
    field :foodallergies, :boolean
    field :other, :boolean
    belongs_to :member, SR.Member

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description])
    |> validate_required([:description])
  end
end
