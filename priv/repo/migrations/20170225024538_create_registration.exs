defmodule SR.Repo.Migrations.CreateRegistration do
  use Ecto.Migration

  def change do
    create table(:registrations) do
      add :type, :string
      add :confirmed?, :boolean, default: false, null: false
      add :member_id, references(:members, on_delete: :nothing)

      timestamps()
    end
    create index(:registrations, [:member_id])

  end
end
