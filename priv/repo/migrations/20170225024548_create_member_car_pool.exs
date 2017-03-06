defmodule SR.Repo.Migrations.CreateMemberCarPool do
  use Ecto.Migration

  def change do
    create table(:members_car_pools) do
      add :member_id, references(:members, on_delete: :nothing)
      add :car_pool_id, references(:car_pools, on_delete: :nothing)

      timestamps()
    end
    create index(:members_car_pools, [:member_id])
    create index(:members_car_pools, [:car_pool_id])

  end
end
