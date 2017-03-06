defmodule SR.Repo.Migrations.CreateActivityCampsite do
  use Ecto.Migration

  def change do
    create table(:activities_camp_sites) do
      add :activity_id, references(:activities, on_delete: :nothing)
      add :camp_site_id, references(:camp_sites, on_delete: :nothing)

      timestamps()
    end
    create index(:activities_camp_sites, [:activity_id])
    create index(:activities_camp_sites, [:camp_site_id])

  end
end
