Set-Location -Path templates

Connect-AzAccount

Get-AzSubscription

$context = Get-AzSubscription -SubscriptionId {Your subscription ID}
Set-AzContext $context

Set-AzDefault -ResourceGroupName learn-7ef44fc1-b84e-4b27-b254-121299890329

New-AzResourceGroupDeployment -Name main -TemplateFile main.bicep -location eastus2 -ResourceGroupName  learn-7ef44fc1-b84e-4b27-b254-121299890329

New-AzResourceGroupDeployment -Name main -TemplateFile main.bicep -environmentName Production -location eastus2 -ResourceGroupName  learn-7ef44fc1-b84e-4b27-b254-121299890329