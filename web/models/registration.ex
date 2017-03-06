defmodule SR.Registration do
  use SR.Web, :model

  schema "registrations" do
    field :type, :string
    field :confirmed?, :boolean, default: false
    belongs_to :member, SR.Member

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :confirmed?])
    |> validate_required([:type, :confirmed?])
  end
end
