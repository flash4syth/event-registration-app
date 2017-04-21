defmodule SR.Repo.Migrations.AdminUpdate do
  use Ecto.Migration

  def change do
    alter table(:admins) do
      add :member_id, references(:members, on_delete: :nothing)
    end

  end
end
