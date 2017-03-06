defmodule SR.Repo.Migrations.CreateSpecialNeed do
  use Ecto.Migration

  def change do
    create table(:special_needs) do
      add :description, :text
      add :member_id, references(:members, on_delete: :nothing)

      timestamps()
    end
    create index(:special_needs, [:member_id])

  end
end
