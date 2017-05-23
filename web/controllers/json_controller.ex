defmodule SR.JsonController do
  use SR.Web, :controller

  def init(conn, _params) do
    wards = from(w in SR.Ward, select: w.name)
      |> Repo.all()

    meals = from(m in SR.Meal, select: %{name: m.name, datetime: m.stringtime,
      location: m.location, image: m.image, blurb: m.blurb,
      image_width: m.image_width, description: m.description,
      image_height: m.image_height, id: m.id}

      )
      |> Repo.all()

    activities = from(a in SR.Activity, select: %{name: a.name,
      datetime: a.stringtime, location: a.location, image: a.image,
      blurb: a.blurb,
      description: a.description, id: a.id, image_width: a.image_width,
      image_height: a.image_height}
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
      }

    } = conn.body_params

    meal_structs = Enum.map(meals, fn meal_id ->
      Repo.get(SR.Meal, meal_id)
    end)

    registration = %SR.Registration{
      type: reg_type,
      confirmed?: false
    }
    |> SR.Registration.changeset()
    |> Repo.insert!()

    new_member = %SR.Member{
        first_name: first_name,
        last_name: last_name,
        email: email,
        phone: phone,
        gender: gender,
        ward: ward,
        registrations: registration,
        meals: meal_structs
    }

    # Handle whether to create and associate a special need for this member
    new_member = (if spec_need_desc == "" do
      new_member
    else
      special_need = %SR.SpecialNeed{
        description: spec_need_desc,
      }
      |> SR.SpecialNeed.changeset()
      |> Repo.insert!()

      Map.update!(new_member, :special_needs, fn _ -> special_need end)
    end)

    new_member
    |> SR.Member.changeset()
    |> Repo.insert!()

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
