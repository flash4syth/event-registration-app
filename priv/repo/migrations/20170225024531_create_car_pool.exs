defmodule SR.Repo.Migrations.CreateCarPool do
  use Ecto.Migration

  def change do
    create table(:car_pools) do
      add :departure_time, :datetime
      add :destination, :string
      add :capacity, :integer
      add :departure_location, :string
      add :driver_id, references(:members, on_delete: :nothing)

      timestamps()
    end
    create index(:car_pools, [:driver_id])

  end
end
