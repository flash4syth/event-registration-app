defmodule SR.Factory do
  alias SR.Repo
  alias SR.{Meal, Member, SpecialNeed, Registration}

  # Factories
  def build(:meal) do
    %Meal{
      name: "#{random(["Breakfast", "Lunch", "Dinner"])}",
      stringtime: "Friday 1:00pm",
      location: "#{random(["A", "B", "C"])}"
    }
  end

  def build(:member) do
    %Member{
      first_name: "John",
      last_name: "Smith",
      email: "jsmith@example.com",
      phone: "555-123-4567",
      gender: "Male",
      age: "25",
      special_needs: %SpecialNeed{
        description: "I need wheelchair access."
      },
      registrations: %Registration{
        type: "Both Days",
        confirmed?: false,
      }
    }
  end

  defp random(enum) do
    Enum.random(enum)
  end
end
