defmodule SR.Admin do
  use SR.Web, :model

  schema "admins" do
    field :is_superadmin, :boolean, default: false
    belongs_to :member, SR.Member

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:is_superadmin])
    |> validate_required([:is_superadmin])
  end
end
