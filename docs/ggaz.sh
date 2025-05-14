# 61e9db97-f7b1-4831-92b8-757e0114f022
subscriptionId="6358b997-b7c0-4d30-b9bd-9ab4057ac712"
region="UKSouth"
results=$(az cognitiveservices usage list --subscription $subscriptionId --location $region) 
echo $results | jq -r '.[] | select(.name.value | test("Standard.gpt-4"))'
echo $results | jq -r '.[] | select(.name.value | test("OpenAI.Standard.text-embedding-ada-002"))'
echo $results | jq -r '.[] | select(.name.value | test("Standard.gpt-35-turbo"))'


curl -fsSL https://aka.ms/install-azd.sh | bash



azd env refresh --subscription 6358b997-b7c0-4d30-b9bd-9ab4057ac712 --tenant-id 61e9db97-f7b1-4831-92b8-757e0114f022

export AZURE_SUBSCRIPTION_ID=6358b997-b7c0-4d30-b9bd-9ab4057ac712
azd auth login --tenant-id 61e9db97-f7b1-4831-92b8-757e0114f022 --use-device-code
azd auth login --tenant-id 797f4846-ba00-4fd7-ba43-dac1f8f63013 --use-device-code
azd auth login --scope https://management.azure.com//.default --tenant-id 61e9db97-f7b1-4831-92b8-757e0114f022 --use-device-code

797f4846-ba00-4fd7-ba43-dac1f8f63013
az account show --tenant 797f4846-ba00-4fd7-ba43-dac1f8f63013


## NEW CODE 
// ...existing code...
curl -fsSL https://aka.ms/install-azd.sh | bash

# Define necessary IDs
mfaTenantId="61e9db97-f7b1-4831-92b8-757e0114f022" # Tenant ID from the MFA error
currentSubscriptionId="6358b997-b7c0-4d30-b9bd-9ab4057ac712" # Your subscription ID

# Export subscription ID for azd and other tools if needed
export AZURE_SUBSCRIPTION_ID="$currentSubscriptionId"

# 1. Log out from azd to ensure a clean authentication state (optional, but helpful for troubleshooting)
azd auth logout

# 2. Authenticate with azd against the correct tenant, using device code for MFA
echo "Attempting azd login with tenant $mfaTenantId. Please follow device code instructions and complete MFA."
azd auth login --tenant-id "$mfaTenantId" --scope "https://management.azure.com//.default" --use-device-code

# 3. Set the active Azure subscription context for Azure CLI (azd uses this)
echo "Setting active Azure subscription to $currentSubscriptionId"
az account set --subscription "$currentSubscriptionId"

# 4. Refresh the azd environment (without unsupported flags)
echo "Refreshing azd environment..."
azd env refresh

# To verify the current Azure CLI context after login and setting subscription:
echo "Current Azure CLI account context:"
az account show

# If you want to list details for the specific tenant:
echo "Details for tenant $mfaTenantId:"
az account tenant list --query "[?tenantId=='$mfaTenantId']"
// ...existing code...