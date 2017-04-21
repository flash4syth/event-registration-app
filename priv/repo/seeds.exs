# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SR.Repo.insert!(%SR.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecto.DateTime, only: [utc: 0]
alias SR.{Meal, Activity}

SR.Repo.insert!(%Meal{
  name: "Friday Dinner",
  stringtime: "Friday 6:00pm",
  location: "Pavilion",
  image: "",
  blurb: "Roast Beef and Bread",
  description: "",
  inserted_at: utc(),
  updated_at: utc()
})

SR.Repo.insert!(%Meal{
  name: "Saturday Breakfast",
  stringtime: "Saturday 8:00am",
  location: "Pavilion",
  image: "",
  blurb: "Breakfast Burritos",
  description: "",
  inserted_at: utc(),
  updated_at: utc()
})

SR.Repo.insert!(%Meal{
  name: "Saturday Lunch",
  stringtime: "Saturday 12:00pm",
  location: "Pavilion",
  image: "",
  blurb: "PB&J Mmmm!",
  description: "Here is a long description",
  inserted_at: utc(),
  updated_at: utc()
})

SR.Repo.insert!(%Activity{
  name: "Friday Night Star Gazing",
  stringtime: "Friday 8:00pm",
  location: "TBD",
  image: "",
  blurb: "Explore the Universe with Brother Lutz",
  description: "Needs Description",
  inserted_at: utc(),
  updated_at: utc()
})

SR.Repo.insert!(%Activity{
  name: "Friday Night Devotional",
  stringtime: "Friday 6:30pm",
  location: "TBD",
  image: "",
  blurb: "Spiritual Message",
  description: "Needs Description",
  inserted_at: utc(),
  updated_at: utc()
})

SR.Repo.insert!(%Activity{
  name: "Saturday Afternoon Speaker: Brad Wilcox",
  stringtime: "Saturday 1:00pm",
  location: "Pavilion",
  image: "",
  blurb: "A wonderful man",
  description: "Needs Description",
  inserted_at: utc(),
  updated_at: utc()
})
