defmodule SR.Repo.Migrations.AddEventImages do
  use Ecto.Migration

  def change do
    alter table(:activities) do
      add :image, :string
    end

    alter table(:meals) do
      add :image, :string
    end

  end
end
