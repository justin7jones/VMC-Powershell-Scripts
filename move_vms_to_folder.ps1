# Script to move CSV list of VMs to specific folder
# Justin Jones
# justinj@vmware.com
# Last Update 05/10/2019

##### ***** SET VALUES BELOW BEFORE RUNNING ****** ######

$vcenter_server_name        = "vcenter01.j2sys.local"
$destination_folder_name    = "jfolder"

#Make sure PowerCLI is installed

if (!(Get-Module | where {$_.Name -eq "VMware.VimAutomation.Core"})) 
	{
		Add-Module VMware.VimAutomation.Core
	}

#Set the participation to false and ignore invalid certificates for all users
Set-PowerCLIConfiguration -Scope AllUsers -ParticipateInCeip $false -InvalidCertificateAction Ignore




# Connect to the specified server
Write-Output "Connecting to vCenter..."
$server = Connect-VIServer -Server $vcenter_server_name

# get the specified folder
Write-Output "Searching for Destination Folder..."
$folder = Get-Folder -Server $server -Name $destination_folder_name

# Read vm_list.txt contents
Write-Output "Reading in Contents of vm_list.txt"

try {
		$vmList = Get-Content "vm_list.txt"
	
	}
catch 	{
			Write-Host "Error parsing vm_list.txt" -ForegroundColor Red
			Write-Host "Error Details: " + $_.Exception.Message  -ForegroundColor Red
			Break
		}	


# get the VMs from the VM Names
Write-Output "Finding VMs from text file in vCenter..."
$vm_objects_to_move = Get-VM $vmList
Write-Host "**********      VMs to MOVE to Folder     **********"
Write-Host $vm_objects_to_move | Format-List -Property Name
Write-Host "****************************************************"

#Move the VMs to the folder
Write-Output "Moving VMs to Folder " + $destination_folder_name
Move-VM -VM $vm_objects_to_move -Destination $folder