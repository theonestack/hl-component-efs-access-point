CloudFormation do

  access_points = external_parameters.fetch(:access_points, {})

  unless access_points.empty?
    access_points.each do |ap|
      EFS_AccessPoint("#{ap['name']}AccessPoint") do
        ClientToken ap['client_token'] if ap.has_key?('client_token')
        AccessPointTags ap['tags'] if ap.has_key?('tags')
        FileSystemId Ref('FileSystemId')
        PosixUser ap['posix_user'] if ap.has_key?('posix_user')
        RootDirectory ap['root_directory'] if ap.has_key?('root_directory')
      end

      Output("#{ap['name']}AccessPoint") {
        Value(Ref("#{ap['name']}AccessPoint"))
        Export FnSub("${EnvironmentName}-#{external_parameters[:component_name]}-#{ap['name']}AccessPoint")
      }
    end
  end  
end