defmodule SR.Repo.Migrations.CreateActivitySpecialNeed do
  use Ecto.Migration

  def change do
    create table(:activities_special_needs) do
      add :activity_id, references(:activities, on_delete: :nothing)
      add :special_need__id, references(:special_needs, on_delete: :nothing)

      timestamps()
    end
    create index(:activities_special_needs, [:activity_id])
    create index(:activities_special_needs, [:special_need__id])

  end
end
