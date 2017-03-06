defmodule SR.Member do
  use SR.Web, :model

  schema "members" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :phone, :string
    field :gender, :string
    field :age, :integer
    # belongs_to :ward, SR.Ward, default: nil
    # belongs_to :admin, SR.Admin, default: nil
    # belongs_to :cabin, SR.Cabin, default: nil
    many_to_many :meals, SR.Meal, join_through: "members_meals"
    has_one :special_needs, SR.SpecialNeed
    has_one :registrations, SR.Registration

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :phone, :gender, :age])
    |> validate_required([:first_name, :last_name, :email, :phone, :gender, :age])
  end
end
