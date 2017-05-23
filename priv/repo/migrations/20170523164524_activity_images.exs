defmodule SR.Repo.Migrations.ActivityImages do
  use Ecto.Migration

  def change do
    alter table(:activities) do
      add :image_width, :integer
      add :image_height, :integer
    end

    alter table(:meals) do
      add :image_width, :integer
      add :image_height, :integer
    end
  end
end
