defmodule SR.Ward do
  use SR.Web, :model

  schema "wards" do
    field :name, :string
    has_many :member, SR.Member

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
