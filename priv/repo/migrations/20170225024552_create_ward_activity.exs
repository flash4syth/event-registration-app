defmodule SR.Repo.Migrations.CreateWardActivity do
  use Ecto.Migration

  def change do
    create table(:wards_activities) do
      add :ward_id, references(:wards, on_delete: :nothing)
      add :activity_id, references(:activities, on_delete: :nothing)

      timestamps()
    end
    create index(:wards_activities, [:ward_id])
    create index(:wards_activities, [:activity_id])

  end
end
