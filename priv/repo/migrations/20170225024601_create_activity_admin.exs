defmodule SR.Repo.Migrations.CreateActivityAdmin do
  use Ecto.Migration

  def change do
    create table(:activities_admins) do
      add :activity_id, references(:activities, on_delete: :nothing)
      add :admin_id, references(:admins, on_delete: :nothing)

      timestamps()
    end
    create index(:activities_admins, [:activity_id])
    create index(:activities_admins, [:admin_id])

  end
end
