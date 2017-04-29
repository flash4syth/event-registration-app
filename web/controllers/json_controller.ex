defmodule SR.JsonController do
  use SR.Web, :controller
  require Logger

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

  def update_activities(conn, _params) do
    event_groups = extract_event_json(conn)

    new_results = (if Map.has_key?(event_groups, :new) do

      Enum.map(event_groups.new, fn event ->
        struct = %SR.Activity{
          name: event["name"],
          stringtime: event["datetime"],
          location: event["location"],
          description: event["description"],
          blurb: event["blurb"],
          image: "need_image.jpg"
        }
        |> SR.Activity.changeset
        |> Repo.insert!

        %{id: struct.id, name: struct.name, datetime: struct.stringtime,
          image: struct.image, location: struct.location,
          description: struct.description, blurb: struct.blurb
        }
      end)
    else
      []
    end)


    update_results = (if Map.has_key?(event_groups, :update) do
      Enum.map(event_groups.update, fn event ->
        struct = %SR.Activity{
          id: event["id"],
          name: event["name"],
          stringtime: event["datetime"],
          location: event["location"],
          description: event["description"],
          blurb: event["blurb"],
          }
        |> SR.Activity.changeset
        |> Repo.update!

        image = (if is_nil(struct.image), do: "need_image.jpg",
          else: struct.image)
        %{id: struct.id, name: struct.name, datetime: struct.stringtime,
          image: image, location: struct.location,
          description: struct.description, blurb: struct.blurb
        }
      end)
    else
      []
    end)

    all_results = Enum.concat(new_results, update_results)

    json conn, all_results
  end

  def update_meals(conn, _params) do
    event_groups = extract_event_json(conn)

    new_results = (if Map.has_key?(event_groups, :new) do

      Enum.map(event_groups.new, fn event ->
        struct = %SR.Meal{
          name: event["name"],
          stringtime: event["datetime"],
          location: event["location"],
          description: event["description"],
          blurb: event["blurb"],
          image: "need_image.jpg"
        }
        |> SR.Meal.changeset
        |> Repo.insert!

        %{id: struct.id, name: struct.name, datetime: struct.stringtime,
          image: struct.image, location: struct.location,
          description: struct.description, blurb: struct.blurb
        }
      end)
    else
      []
    end)


    update_results = (if Map.has_key?(event_groups, :update) do
      Enum.map(event_groups.update, fn event ->
        struct = %SR.Meal{
          id: event["id"],
          name: event["name"],
          stringtime: event["datetime"],
          location: event["location"],
          description: event["description"],
          blurb: event["blurb"],
          }
        |> SR.Meal.changeset
        |> Repo.update!

        image = (if is_nil(struct.image), do: "need_image.jpg",
          else: struct.image)
        %{id: struct.id, name: struct.name, datetime: struct.stringtime,
          image: image, location: struct.location,
          description: struct.description, blurb: struct.blurb
        }
      end)
    else
      []
    end)

    all_results = Enum.concat(new_results, update_results)

    json conn, all_results
  end

  def register(conn, _params) do

    %{
      "first_name" => first_name,
      "last_name" => last_name,
      "email" => email,
      "phone" => phone,
      "gender" => gender,
      "meals" => meals,
      "reg_type" => reg_type,
      "ward" => ward,
      "special_needs" => %{
        "description" => spec_need_desc,
        "need_types" => %{
          "foodAllergy" => is_foodAllergy,
          "other" => is_other,
          "wheelChair" => is_wheelChair
        }
      }

    } = registration = conn.body_params

    new_member = %SR.Member{
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone: phone,
      gender: gender,
      ward: ward
    }
    |> SR.Member.changeset()
    |> Repo.insert!()

    # %SR.SpecialNeed{
    #   member: new_member,
    #   wheelchair: ["special_needs"]["need_types"]["wheelChair"]
    # }

    json conn, "Success!"
  end

  # extract event json into two groups--new events or events marked for
  # updating new events are indicated by "id" => -1
  defp extract_event_json(conn) do
    Enum.group_by(conn.body_params["_json"], fn event ->
        case event["id"] do
          -1 -> :new
          _  -> :update
        end
      end)
  end

end
