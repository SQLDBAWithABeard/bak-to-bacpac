# A Script to run all of the required scripts in order
# A beginning step to modulisation I guess

# First Set the variables in the variables.ps1 file to the required values

# Make sure your prompt is at the root of the repository and run.

. ./container/PowerShell/variables.ps1 

## To create a local container image and run it
# This will load any .bak files in the localDockerHostDirectory

<#
# to create the create_docker_image.sh file with the details filled in use this code
(Get-Content ./container/Docker/create_docker_image.sh) -replace '__SA_PASSWORD__', $containerSaPassword.GetNetworkCredential().Password -replace '__LOCAL_HOST_DIRECTORY__',$localDockerHostDirectory | Set-Content $dockertempcreateimage

#>
Set-Location ./container/Docker


#build the image
docker build -t mssql-bak-bacpac .

$localdockerrun = ('docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=__SA_PASSWORD__" -v __LOCAL_HOST_DIRECTORY__:/mnt/external  --name bak-to-bacpac mssql-bak-bacpac' -replace '__SA_PASSWORD__', $containerSaPassword.GetNetworkCredential().Password -replace '__LOCAL_HOST_DIRECTORY__',$localDockerHostDirectory)

Invoke-Expression $localdockerrun