# azure CLI

az deployment group create --template-file main.bicep --parameters main.parameters.dev.json --resource-group learn-e5875d05-aaea-4cf6-ae56-209bfa1a894b

keyVaultName='cristian-keyvault'
read -s -p "Enter the login name: " login
read -s -p "Enter the password: " password

az keyvault create --name $keyVaultName --location eastus --enabled-for-template-deployment true --resource-group learn-e5875d05-aaea-4cf6-ae56-209bfa1a894b
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorLogin" --value $login --output none
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorPassword" --value $password --output none

# powershell

New-AzResourceGroupDeployment -TemplateFile main.bicep -TemplateParameterFile main.parameters.dev.json --ResourceGroupName learn-e5875d05-aaea-4cf6-ae56-209bfa1a894b

$keyVaultName = 'cristian-keyvault'
$login = Read-Host "Enter the login name" -AsSecureString
$password = Read-Host "Enter the password" -AsSecureString

New-AzKeyVault -VaultName $keyVaultName -Location eastus2 -EnabledForTemplateDeployment --ResourceGroupName learn-e5875d05-aaea-4cf6-ae56-209bfa1a894b
Set-AzKeyVaultSecret -VaultName $keyVaultName -Name 'sqlServerAdministratorLogin' -SecretValue $login
Set-AzKeyVaultSecret -VaultName $keyVaultName -Name 'sqlServerAdministratorPassword' -SecretValue $password

(Get-AzKeyVault -Name $keyVaultName).ResourceId

New-AzResourceGroupDeployment -Name main -TemplateFile main.bicep -TemplateParameterFile main.parameters.dev.json -ResourceGroupName  learn-e5875d05-aaea-4cf6-ae56-209bfa1a894b