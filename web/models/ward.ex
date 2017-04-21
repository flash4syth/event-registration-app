defmodule SR.Ward do
  use SR.Web, :model

  schema "wards" do
    field :name, :string
    field :member_count, :integer
    field :bishop_last_name, :string
    has_many :member, SR.Member

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :member_count, :bishop_last_name])
    |> validate_required([:name, :member_count, :bishop_last_name])
  end
end
