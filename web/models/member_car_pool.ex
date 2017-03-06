defmodule SR.MemberCarPool do
  use SR.Web, :model

  schema "members_car_pools" do
    belongs_to :member, SR.Member
    belongs_to :car_pool, SR.CarPool

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
