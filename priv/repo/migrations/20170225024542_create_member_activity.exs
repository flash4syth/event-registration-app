defmodule SR.Repo.Migrations.CreateMemberActivity do
  use Ecto.Migration

  def change do
    create table(:members_activities) do
      add :activity_id, references(:activities, on_delete: :nothing)
      add :member_id, references(:members, on_delete: :nothing)

      timestamps()
    end
    create index(:members_activities, [:activity_id])
    create index(:members_activities, [:member_id])

  end
end
