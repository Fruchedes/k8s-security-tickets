Azure ARM Templates and Bicep


1. Introduction
What are ARM Templates?
Azure Resource Manager (ARM) Templates are JSON files that define the infrastructure and configuration for your Azure resources.
They allow you to deploy and manage Azure resources consistently.
What is Bicep?
Bicep is a domain-specific language (DSL) for deploying Azure resources.
It offers a simpler, more readable syntax compared to ARM templates, while still transpiling to standard ARM templates.


2. Purpose and Scope
Purpose
To automate the deployment and management of Azure resources.
To provide a declarative syntax for defining infrastructure.
Scope
ARM templates and Bicep can be used for a variety of Azure resources including virtual machines, storage accounts, and networking components.
They support complex deployments including nested and linked templates.


3. Parameters and Variables
Parameters
Purpose: To make templates reusable by allowing input values at deployment time.
Syntax:
json

{
  "parameters": {
    "storageAccountType": {
      "type": "string",
      "defaultValue": "Standard_LRS",
      "allowedValues": ["Standard_LRS", "Standard_GRS", "Standard_ZRS", "Premium_LRS"],
      "metadata": {
        "description": "Storage Account type"
      }
    }
  }
}
Variables
Purpose: To define values that can be reused within the template.
Syntax:
json

{
  "variables": {
    "storageAccountName": "[concat('storage', uniqueString(resourceGroup().id))]"
  }
}

4. Template Syntax
ARM Template Syntax
Structure:

{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": { },
  "variables": { },
  "resources": [ ],
  "outputs": { }
}
Bicep Syntax
Structure:

param storageAccountType string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'mystorageaccount'
  location: 'westus'
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
}

5. Real-World Examples
ARM Template Example

{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "storageAccountType": {
      "type": "string",
      "defaultValue": "Standard_LRS",
      "allowedValues": [
        "Standard_LRS",
        "Standard_GRS",
        "Standard_ZRS",
        "Premium_LRS"
      ],
      "metadata": {
        "description": "Storage Account type"
      }
    }
  },
  "resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2019-04-01",
      "name": "[concat('storage', uniqueString(resourceGroup().id))]",
      "location": "[resourceGroup().location]",
      "sku": {
        "name": "[parameters('storageAccountType')]"
      },
      "kind": "StorageV2",
      "properties": {}
    }
  ]
}
Bicep Example

param storageAccountType string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'mystorageaccount'
  location: 'westus'
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
}

6. Additional Information
Best Practices
Modular Templates: Break down large templates into smaller, reusable components.
Parameter Files: Use parameter files to manage different configurations for different environments.
Version Control: Store templates in a version control system like Git for better collaboration and tracking changes.
Tools and Resources
Azure Resource Manager Documentation: ARM Templates Documentation
Bicep Documentation: Bicep Documentation
Azure Quickstart Templates: GitHub Repository
Transitioning from ARM to Bicep
Use the Bicep CLI to decompile existing ARM templates to Bicep:


bicep decompile mytemplate.json


7. Conclusion
ARM templates and Bicep provide robust solutions for managing Azure infrastructure as code.
While ARM templates are powerful and widely used, Bicep simplifies the authoring process with a more user-friendly syntax.
Understanding both tools will help you automate and streamline your Azure deployments effectively.