# efs-access-point CfHighlander component
## Parameters

| Name | Use | Default | Global | Type | Allowed Values |
| ---- | --- | ------- | ------ | ---- | -------------- |
| EnvironmentName | Tagging | dev | true | string
| EnvironmentType | Tagging | development | true | string | ['development','production']
| FileSystemId | File System ID to connect to | None | false | AWS::EFS::FileSystem::Id

## Outputs/Exports

| Name | Value | Exported |
| ---- | ----- | -------- |
| {ap_name}AccessPoint | AccessPoint name

## Example Configuration
### Highlander
```
  Component name: 'efsaccesspoint', template: 'efs-access-point' do
    parameter name: 'FileSystemId', value: cfout('efs', 'FileSystemId')
  end
```
### EFS Access Point Configuration
```
access_points:
  -
    name: AppData
    root_directory:
      CreationInfo:
        OwnerGid: '33'
        OwnerUid: '33'
        Permissions: '774'
      Path: /app_data
  -
    name: AppLogs
    root_directory:
      CreationInfo:
        OwnerGid: '33'
        OwnerUid: '33'
        Permissions: '774'
      Path: /app_logs
```

## Configuration


**Extra Tags**
Optionally add extra tags from the config file.
```yaml
extra_tags:
    key: value
```

## Cfhighlander Setup

install cfhighlander [gem](https://github.com/theonestack/cfhighlander)

```bash
gem install cfhighlander
```

or via docker

```bash
docker pull theonestack/cfhighlander
```
## Testing Components

Running the tests

```bash
cfhighlander cftest efs-access-point
```