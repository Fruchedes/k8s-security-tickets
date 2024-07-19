@description('The name of the Azure Analysis Services server to create. Server name must begin with a letter, be lowercase alphanumeric, and between 3 and 63 characters in length. Server name must be unique per region.')
param serverName string

@description('Location of the Azure Analysis Services server. For supported regions, see https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region')
param location string = resourceGroup().location

@description('The sku name of the Azure Analysis Services server to create. Choose from: B1, B2, D1, S0, S1, S2, S3, S4, S8, S9. Some skus are region specific. See https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region')
param skuName string = 'S0'

@description('The total number of query replica scale-out instances. Scale-out of more than one instance is supported on selected regions only. See https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region')
param capacity int = 1

@description('The inbound firewall rules to define on the server. If not specified, firewall is disabled.')
param firewallSettings object = {
  firewallRules: [
    {
      firewallRuleName: 'AllowFromAll'
      rangeStart: '0.0.0.0'
      rangeEnd: '255.255.255.255'
    }
  ]
  enablePowerBIService: true
}

@description('The SAS URI to a private Azure Blob Storage container with read, write and list permissions. Required only if you intend to use the backup/restore functionality. See https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-backup')
param backupBlobContainerUri string = ''

@description('The name of the Azure SQL Database server to create.')
param sqlServerName string

@description('The name of the Azure SQL Database to create.')
param sqlDatabaseName string

@description('The name of the Azure Storage Account to create.')
param storageAccountName string

@description('The kind of the Azure Storage Account to create.')
param storageAccountKind string = 'StorageV2'

@description('The sku of the Azure Storage Account to create.')
param storageAccountSku string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: storageAccountKind
  sku: {
    name: storageAccountSku
  }
}

resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: 'adminUser'
    administratorLoginPassword: 'Password123!'
  }
  dependsOn: [
    storageAccount
  ]
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: '${sqlServerName}/${sqlDatabaseName}'
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 1073741824
  }
  dependsOn: [
    sqlServer
  ]
}

resource server 'Microsoft.AnalysisServices/servers@2017-08-01' = {
  name: serverName
  location: location
  sku: {
    name: skuName
    capacity: capacity
  }
  properties: {
    ipV4FirewallSettings: firewallSettings
    backupBlobContainerUri: backupBlobContainerUri
  }
  dependsOn: [
    storageAccount
    sqlDatabase
  ]
}

output storageAccountId string = storageAccount.id
output sqlServerId string = sqlServer.id
output sqlDatabaseId string = sqlDatabase.id
output analysisServicesServerId string = server.id
