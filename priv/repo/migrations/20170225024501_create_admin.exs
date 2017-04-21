defmodule SR.Repo.Migrations.CreateAdmin do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :is_superadmin, :boolean, default: false, null: false
      # add :member_id, references(:members, on_delete: :nothing)

      timestamps()
    end
    # create index(:admins, [:admin_id])

  end
end
