$param1 = $args[0]

switch($param1) {
	-System {"Summary of System"
		systemdetails
		video}
	-Disks {"Summary of physical drives"
		disk}
	-Network {"Summary of network"
		network}
	default {"Invalid input"}
}