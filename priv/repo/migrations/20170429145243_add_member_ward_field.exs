defmodule SR.Repo.Migrations.AddMemberWardField do
  use Ecto.Migration

  def change do
    alter table(:members) do
      add :ward, :string
    end
  end
end
