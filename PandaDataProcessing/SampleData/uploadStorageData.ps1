<#
.SYNOPSIS 
uploadStorageData.ps1.ps1 uploads the sample data and script to your Azure Storage.

.DESCRIPTION
Remember to update the storage account name, storage account key before running the script.

.NOTES 
File Name : uploadStorageData.ps1
Version   : 2.0
#>    
&.\ImportAzureModule.ps1

$storageAccount = "pandadatastorage"
$storageKey = "ln/Bm4YLrx0Y7WUd3+boEvUqgBOIhxopPUMyiHub9X+4hsrrc1POS7NtQG3O1tORcLXnCzLoT4KmCaNmjkIPzw=="

$adfcontainerName = "adfsampledata"
Write-Verbose   "Preparing the storage account. Adding the container [$adfcontainerName]"
$destContext = New-AzureStorageContext  -StorageAccountName $storageAccount -StorageAccountKey $storageKey -ea silentlycontinue
If ($destContext -eq $Null) {
	Write-Error "Invalid storage account name and/or storage key provided"
	Exit
}


#check whether the Azure storage container already exists
$container = Get-AzureStorageContainer -Name $adfcontainerName -context $destContext -ea silentlycontinue
If ($container -eq $Null) {
	Write-Verbose "Creating storage container [$adfcontainerName]"
	New-AzureStorageContainer -Name $adfcontainerName -context $destContext 
}
else {
	Write-Verbose "[$adfcontainerName] exists."
}

# STEP 1- Upload sample data and script files to the blob container
Write-Verbose  "Uploading sample data and script files to the storage container [$adfcontainerName]"
Set-AzureStorageBlobContent -File ".\part-r-00000-1"  -Container $adfcontainerName -Context $destContext -Blob "logs/enrichedgameevents/yearno=2015/monthno=04/dayno=01/" -Force
Set-AzureStorageBlobContent -File ".\part-r-00000-2"  -Container $adfcontainerName -Context $destContext -Blob "logs/enrichedgameevents/yearno=2015/monthno=04/dayno=02/" -Force
Set-AzureStorageBlobContent -File ".\part-r-00000-3"  -Container $adfcontainerName -Context $destContext -Blob "logs/enrichedgameevents/yearno=2015/monthno=04/dayno=03/" -Force
Set-AzureStorageBlobContent -File ".\part-r-00000-4"  -Container $adfcontainerName -Context $destContext -Blob "logs/enrichedgameevents/yearno=2015/monthno=04/dayno=04/" -Force
