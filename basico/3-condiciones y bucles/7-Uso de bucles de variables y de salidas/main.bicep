var items = [for i in range(1, 5): 'item${i}']
// En el ejemplo anterior se crea una matriz que contiene los valores item1, item2, item3, item4 y item5.

param addressPrefix string = '10.10.0.0/16'
param subnets array = [
  {
    name: 'frontend'
    ipAddressRange: '10.10.0.0/24'
  }
  {
    name: 'backend'
    ipAddressRange: '10.10.1.0/24'
  }
]

var subnetsProperty = [for subnet in subnets: {
  name: subnet.name
  properties: {
    addressPrefix: subnet.ipAddressRange
  }
}]

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'teddybear'
  location: resourceGroup().location
  properties:{
    addressSpace:{
      addressPrefixes:[
        addressPrefix
      ]
    }
    subnets: subnetsProperty
  }
}
// En este ejemplo se muestra un uso eficaz de los bucles de variables: convertir un parámetro con valores sencillos y fáciles de entender en un objeto más complejo que se corresponda con la definición requerida del recurso de Azure. Puede usar bucles de variables para permitir que los parámetros especifiquen solo la información clave que cambiará para cada elemento de la lista. Después, puede usar expresiones de Bicep o valores predeterminados para establecer otras propiedades necesarias para el recurso.


var items = [
  'item1'
  'item2'
  'item3'
  'item4'
  'item5'
]

output outputItems array = [for i in range(0, length(items)): items[i]]
// Normalmente, usará bucles de salidas junto con otros bucles dentro de la plantilla. Por ejemplo, echemos un vistazo a un archivo de Bicep que implementa un conjunto de cuentas de almacenamiento en las regiones de Azure especificadas por el parámetro locations:
param locations array = [
  'westeurope'
  'eastus2'
  'eastasia'
]

resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-05-01' = [for location in locations: {
  name: 'toy${uniqueString(resourceGroup().id, location)}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]
// Probablemente tendrá que devolver información sobre cada cuenta de almacenamiento que ha creado, como su nombre y los puntos de conexión que se pueden usar para acceder a ella. Mediante un bucle de salidas, puede recuperar esta información en el archivo de Bicep.
// Nota: Actualmente, Bicep no admite la referencia directa a los recursos que se han creado dentro de un bucle desde dentro de un bucle de salidas. Esto significa que debe usar indexadores de matriz para acceder a los recursos, como se muestra en el ejemplo siguiente.
output storageEndpoints array = [for i in range(0, length(locations)): {
  name: storageAccounts[i].name
  location: storageAccounts[i].location
  blobEndpoint: storageAccounts[i].properties.primaryEndpoints.blob
  fileEndpoint: storageAccounts[i].properties.primaryEndpoints.file
}]
