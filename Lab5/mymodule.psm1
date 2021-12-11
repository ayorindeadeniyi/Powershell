function welcome {
write-output "Welcome to planet $env:sayorin Overlord $env:ayorinde"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."
}

function get-cpuinfo {
get-ciminstance cim_processor
}

function get-mydisks {
get-physicaldisk
}

function disk {
$diskdrives = Get-CIMInstance CIM_diskdrive
foreach ($disk in $diskdrives) {
	$partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      	foreach ($partition in $partitions) {
		$logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
		foreach ($logicaldisk in $logicaldisks) {
			new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               }
		}
	}
}
}

function network {
$adaptors = get-ciminstance win32_networkadapterconfiguration | ? ipenabled
$adaptors | select-object Description,index,ipaddress,subnetmask,DNSDomain,DNSServerSearchOrder | Format-Table -AutoSize
}

function video {
$videocard = Get-CimInstance -ClassName Win32_videocontroller
foreach ($card in $videocard) {
	new-object -typename psobject -property @{Manufacturer=$card.Description
						processor=$card.VideoProcessor	
						VideoMode=$card.VideoModeDescription	
						}
}
}

function systemdetails {
"System Hardware Description"
Get-CimInstance -ClassName win32_computerSystem

"Operating System Description"
Get-CimInstance -ClassName win32_operatingsystem

"Processor Description"
Get-CimInstance -ClassName win32_processor

"Summary of RAM"
Get-CimInstance -ClassName win32_physicalmemory | select-object Manufacturer,Description,Capacity,BankLabel,DeviceLocator
}