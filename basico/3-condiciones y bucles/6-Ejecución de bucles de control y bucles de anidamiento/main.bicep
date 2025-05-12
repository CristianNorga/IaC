// normal
resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = [for i in range(1,3): {
  name: 'app${i}'
  // ...
}]

// Bicep espera a que finalice cada lote completo antes de pasar al siguiente. En el ejemplo anterior, si app2 finaliza su implementación antes de app1, Bicep espera hasta que app1 finalice antes de empezar a implementar app3.
@batchSize(2)
// @batchSize(1) Al implementar la plantilla, Bicep espera a que termine de implementarse cada recurso antes de iniciar el siguiente
resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = [for i in range(1,3): {
  name: 'app${i}'
  // ...
}]

param subnetNames array = [
  'api'
  'worker'
]

// Uso de bucles con propiedades de recursos
// Puede usar bucles para ayudar a establecer las propiedades de los recursos. Por ejemplo, al implementar una red virtual, debe especificar sus subredes. Una subred debe tener dos fragmentos de información importante: un nombre y un prefijo de dirección. Puede usar un parámetro con una matriz de objetos para especificar subredes diferentes para cada entorno

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'teddybear'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [for (subnetName, i) in subnetNames: {
      name: subnetName
      properties: {
        addressPrefix: '10.0.${i}.0/24'
      }
    }]
  }
}
// En este ejemplo, observe que el bucle for aparece dentro de la definición de recurso, alrededor del valor de propiedad subnets.

// Bucles anidados
// En algunos escenarios es necesario usar un bucle dentro de otro o un bucle anidado. Puede crear bucles anidados mediante la herramienta Bicep.

// En la empresa de ositos de peluche, debe implementar redes virtuales en todos los países o regiones en los que se vaya a lanzar el juguete. Cada red virtual necesita un espacio de direcciones diferente y dos subredes. Para empezar, vamos a implementar las redes virtuales en un bucle
param locations array = [
  'westeurope'
  'eastus2'
  'eastasia'
]

var subnetCount = 2

resource virtualNetworks 'Microsoft.Network/virtualNetworks@2024-05-01' = [for (location, i) in locations : {
  name: 'vnet-${location}'
  location: location
  properties: {
    addressSpace:{
      addressPrefixes:[
        '10.${i}.0.0/16'
      ]
    }
  }
}]
// Este bucle implementa las redes virtuales en cada ubicación y establece el valor de addressPrefix de la red virtual mediante el índice de bucle para tener la seguridad de que cada red virtual obtiene un prefijo de dirección diferente.

// Puede usar un bucle anidado para implementar las subredes dentro de cada red virtual:
resource virtualNetworks 'Microsoft.Network/virtualNetworks@2024-05-01' = [for (location, i) in locations : {
  name: 'vnet-${location}'
  location: location
  properties: {
    addressSpace:{
      addressPrefixes:[
        '10.${i}.0.0/16'
      ]
    }
    subnets: [for j in range(1, subnetCount): {
      name: 'subnet-${j}'
      properties: {
        addressPrefix: '10.${i}.${j}.0/24'
      }
    }]
  }
}]
// El bucle anidado usa la función range() para crear dos subredes.

// Al implementar la plantilla, se obtienen las siguientes redes virtuales y subredes:
// Nombre de la red virtual	Ubicación	Prefijo de dirección	Subredes
// vnet-westeurope	westeurope	10.0.0.0/16	10.0.1.0/24, 10.0.2.0/24
// vnet-eastus2	eastus2	10.1.0.0/16	10.1.1.0/24, 10.1.2.0/24
// vnet-eastasia	eastasia	10.2.0.0/16	10.2.1.0/24, 10.2.2.0/24
