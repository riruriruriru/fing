date_format = activity.all_day_activity? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.id activity.id
json.title activity.title
json.start activity.start.strftime(date_format)
json.end activity.end.strftime(date_format)

json.color activity.color unless activity.color.blank?
json.allDay activity.all_day_activity? ? true : false

json.update_url activity_path(activity, method: :patch)
json.edit_url edit_activity_path(activity