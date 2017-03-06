defmodule SR.Repo.Migrations.CreateWard do
  use Ecto.Migration

  def change do
    create table(:wards) do
      add :name, :string
      add :member_count, :integer
      add :bishop_last_name, :string

      timestamps()
    end

  end
end
