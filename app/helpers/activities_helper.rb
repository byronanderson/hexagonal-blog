module ActivitiesHelper
  def activity_string(activity)
    string = ""
    string << activity.created_at.to_s
    string << ": "
    string << activity.content
    return string
  end
end
