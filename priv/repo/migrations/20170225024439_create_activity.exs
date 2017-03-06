defmodule SR.Repo.Migrations.CreateActivity do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :name, :string
      add :start_datetime, :datetime
      add :end_datetime, :datetime
      add :location, :string
      add :description, :text

      timestamps()
    end

  end
end
