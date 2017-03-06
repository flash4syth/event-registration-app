defmodule SR.Repo.Migrations.CreateMember do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone, :string
      add :gender, :string
      add :age, :integer
      # add :ward_id, references(:Ward, on_delete: :nothing)
      # add :admin_id, references(:Admin, on_delete: :nothing)
      # add :cabin_id, references(:Cabin, on_delete: :nothing)

      timestamps()
    end
    # create index(:members, [:ward_id])
    # create index(:members, [:admin_id])
    # create index(:members, [:cabin_id])

  end
end
