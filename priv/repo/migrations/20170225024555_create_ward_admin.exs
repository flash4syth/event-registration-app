defmodule SR.Repo.Migrations.CreateWardAdmin do
  use Ecto.Migration

  def change do
    create table(:wards_admins) do
      add :ward_id, references(:wards, on_delete: :nothing)
      add :admin_id, references(:admins, on_delete: :nothing)

      timestamps()
    end
    create index(:wards_admins, [:ward_id])
    create index(:wards_admins, [:admin_id])

  end
end
