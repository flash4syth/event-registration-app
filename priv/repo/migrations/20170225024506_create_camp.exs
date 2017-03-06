defmodule SR.Repo.Migrations.CreateCamp do
  use Ecto.Migration

  def change do
    create table(:camps) do
      add :name, :string

      timestamps()
    end

  end
end
