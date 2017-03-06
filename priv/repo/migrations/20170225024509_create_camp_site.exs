defmodule SR.Repo.Migrations.CreateCampSite do
  use Ecto.Migration

  def change do
    create table(:camp_sites) do
      add :number, :integer
      add :camp_id, references(:camps, on_delete: :nothing)

      timestamps()
    end
    create index(:camp_sites, [:camp_id])

  end
end
