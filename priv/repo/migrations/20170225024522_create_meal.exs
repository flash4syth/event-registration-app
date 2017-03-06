defmodule SR.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string
      add :time, :time
      add :location, :string
      
      timestamps()
    end

  end
end
