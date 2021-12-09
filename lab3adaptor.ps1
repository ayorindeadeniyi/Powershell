$adaptors = get-ciminstance win32_networkadapterconfiguration | ? ipenabled
$adaptros | select-object Description,index,ipaddress,subnetmask,DNSDomain,DNSServerSearchOrder | Format-Table -AutoSize
