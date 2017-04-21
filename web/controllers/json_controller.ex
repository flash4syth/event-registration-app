defmodule SR.JsonController do
  use SR.Web, :controller

  def init(conn, _params) do
    wards = from(w in SR.Ward, select: w.name)
      |> Repo.all()

    meals = from(m in SR.Meal, select: %{name: m.name, date: m.stringtime,
      location: m.location, image: m.image, blurb: m.blurb,
      description: m.description}
      )
      |> Repo.all()

    activities = from(m in SR.Activity, select: %{name: m.name,
      date: m.stringtime, location: m.location, image: m.image, blurb: m.blurb,
      description: m.description}
      )
      |> Repo.all()

    payload = %{data: %{wards: wards,
      meals: meals,
      activities: activities
      }
    }
    json conn, payload
  end
end
