CloudFormation do

  tags, lifecycles = Array.new(2){[]}
  tags.push(
    { Key: 'Environment', Value: Ref(:EnvironmentName) },
    { Key: 'EnvironmentType', Value: Ref(:EnvironmentType) },
    { Key: 'Name', Value: FnSub("${EnvironmentName}-#{external_parameters[:component_name]}")}
  )

  extra_tags = external_parameters.fetch(:extra_tags, {})
  tags.push(*extra_tags.map {|k,v| {Key: k, Value: FnSub(v)}}).uniq! { |h| h[:Key] }

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