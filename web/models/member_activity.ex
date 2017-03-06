defmodule SR.MemberActivity do
  use SR.Web, :model

  schema "members_activities" do
    belongs_to :activity, SR.Activity
    belongs_to :member, SR.Member

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
