defmodule SR.Repo.Migrations.CreateAdminCabin do
  use Ecto.Migration

  def change do
    create table(:admins_cabins) do
      add :admin_id, references(:admins, on_delete: :nothing)
      add :cabin_id, references(:cabins, on_delete: :nothing)

      timestamps()
    end
    create index(:admins_cabins, [:admin_id])
    create index(:admins_cabins, [:cabin_id])

  end
end
