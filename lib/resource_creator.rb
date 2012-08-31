require 'talker'

class ResourceCreator < Talker
  def create_with(params)
    resource = scope.new(params)
    if resource.save
      say :"#{resource_name}_creation_succeeded", resource
    else
      say :"#{resource_name}_creation_failed", resource
    end
  end
end
