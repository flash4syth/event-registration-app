defmodule SR.Repo.Migrations.CreateCabin do
  use Ecto.Migration

  def change do
    create table(:cabins) do
      add :number, :string
      add :capacity, :integer
      add :campsite_id, references(:camp_sites, on_delete: :nothing)

      timestamps()
    end
    create index(:cabins, [:campsite_id])

  end
end
