Set-Location -Path templates

Get-AzSubscription

$context = Get-AzSubscription -SubscriptionId dfa615b4-00fa-4919-b751-c26935f11ebe

Set-AzContext $context

Set-AzDefault -ResourceGroupName learn-0013f823-be88-4c1d-b46a-659100d29287

New-AzResourceGroupDeployment -Name main -TemplateFile main.bicep

Get-AzResourceGroupDeployment -ResourceGroupName learn-0013f823-be88-4c1d-b46a-659100d29287 | Format-Table