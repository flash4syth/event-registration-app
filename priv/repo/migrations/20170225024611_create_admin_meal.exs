defmodule SR.Repo.Migrations.CreateAdminMeal do
  use Ecto.Migration

  def change do
    create table(:admins_meals) do
      add :admin_id, references(:admins, on_delete: :nothing)
      add :meal_id, references(:meals, on_delete: :nothing)

      timestamps()
    end
    create index(:admins_meals, [:admin_id])
    create index(:admins_meals, [:meal_id])

  end
end
