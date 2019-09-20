# Script to reschedule all HCX migrations to 2 minutes from now
# Justin Jones
# Last Update 09/20/2019

#based off docs at: https://code.vmware.com/docs/7788/cmdlet-reference/doc/Get-HCXMigration.html

##### ***** SET VALUES BELOW BEFORE RUNNING ****** ######



$hcx_server_name        = "hcxfqdn.rainpole.com"


Connect-HCXServer -Server $hcx_server_name

$list_of_migrations = Get-HCXMigration -MigrationType Bulk

foreach ($migration in $list_of_migrations)     {



    Set-HCXMigration -ScheduleStartTime '06/07/2019 3:05 PM' -ScheduleEndTime '06/17/2019 3:15 PM' -Migration $migration -Whatif



                                                }
