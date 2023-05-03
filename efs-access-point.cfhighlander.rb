CfhighlanderTemplate do
  Name 'efs-access-point'
  Description "efs-access-point - #{component_version}"

  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', allowedValues: ['development','production'], isGlobal: true
    ComponentParam 'FileSystemId', type: 'AWS::EFS::FileSystem::Id'
  end
end