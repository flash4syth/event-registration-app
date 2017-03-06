defmodule SR.Repo.Migrations.CreateMealItem do
  use Ecto.Migration

  def change do
    create table(:meal_items) do
      add :description, :string
      add :cost, :float
      add :store_origin, :string
      add :meal_id, references(:meals, on_delete: :nothing)
      add :admin_id, references(:admins, on_delete: :nothing)

      timestamps()
    end
    create index(:meal_items, [:meal_id])
    create index(:meal_items, [:admin_id])

  end
end
