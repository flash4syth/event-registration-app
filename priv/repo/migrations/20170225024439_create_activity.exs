defmodule SR.Repo.Migrations.CreateActivity do
  use Ecto.Migration

  def change do
    create table(:activities) do
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
