defmodule SR.Repo.Migrations.CreateMemberMeal do
  use Ecto.Migration

  def change do
    create table(:members_meals) do
      add :member_id, references(:members, on_delete: :nothing)
      add :meal_id, references(:meals, on_delete: :nothing)

      timestamps()
    end
    create index(:members_meals, [:member_id])
    create index(:members_meals, [:meal_id])

  end
end
