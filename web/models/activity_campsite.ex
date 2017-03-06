defmodule SR.ActivityCampsite do
  use SR.Web, :model

  schema "activities_camp_sites" do
    belongs_to :activity, SR.Activity
    belongs_to :camp_site, SR.CampSite

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
