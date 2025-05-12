# Description: This script demonstrates how to use parameters in a PowerShell script.

$PSScriptRoot = 'F:\job\SISTE\laboratory\plantillaORM\2-parametros\3-Adición de parámetros y decoradores'

Set-Location -Path $PSScriptRoot

Connect-AzAccount

Get-AzSubscription

$context = Get-AzSubscription -SubscriptionId {Your subscription ID}
Set-AzContext $context

Set-AzDefault -ResourceGroupName learn-e5875d05-aaea-4cf6-ae56-209bfa1a894b

New-AzResourceGroupDeployment -Name main -TemplateFile main.bicep -ResourceGroupName learn-e5875d05-aaea-4cf6-ae56-209bfa1a894b