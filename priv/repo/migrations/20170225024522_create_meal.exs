defmodule SR.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string
      add :start_datetime, :datetime, null: true
      add :stringtime, :string
      add :end_datetime, :datetime, null: true
      add :location, :string
      add :description, :string
      add :blurb, :string

      timestamps()
    end

  end
end
