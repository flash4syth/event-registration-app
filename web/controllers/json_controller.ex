defmodule SR.JsonController do
  use SR.Web, :controller

  def init(conn, _params) do
    wards = from(w in SR.Ward, select: w.name)
      |> Repo.all()

    meals = from(m in SR.Meal, select: %{name: m.name, datetime: m.stringtime,
      location: m.location, image: m.image, blurb: m.blurb,
      description: m.description, id: m.id}
      )
      |> Repo.all()

    activities = from(a in SR.Activity, select: %{name: a.name,
      datetime: a.stringtime, location: a.location, image: a.image, blurb: a.blurb,
      description: a.description, id: a.id}
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
