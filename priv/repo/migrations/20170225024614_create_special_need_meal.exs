defmodule SR.Repo.Migrations.CreateSpecialNeedMeal do
  use Ecto.Migration

  def change do
    create table(:special_needs_meals) do
      add :special_need__id, references(:special_needs, on_delete: :nothing)
      add :meal_id, references(:meals, on_delete: :nothing)

      timestamps()
    end
    create index(:special_needs_meals, [:special_need__id])
    create index(:special_needs_meals, [:meal_id])

  end
end
