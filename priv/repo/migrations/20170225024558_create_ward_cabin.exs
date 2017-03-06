defmodule SR.Repo.Migrations.CreateWardCabin do
  use Ecto.Migration

  def change do
    create table(:wards_cabins) do
      add :ward_id, references(:wards, on_delete: :nothing)
      add :cabin_id, references(:cabins, on_delete: :nothing)

      timestamps()
    end
    create index(:wards_cabins, [:ward_id])
    create index(:wards_cabins, [:cabin_id])

  end
end
