proc renumber { sel start } {
	if { [$sel num] == 0 } {
		puts "Error in renumber: empty selection!"
		return
	}

	set oresid [ $sel get resid ]
	set nresid { }
    set num 0
    set previous  [ lindex $oresid 0 ]

	foreach r $oresid {
        if { $previous != $r } {
            set previous $r
            incr num
        }
        lappend nresid [expr $start + $num]
	}
	
    $sel set resid $nresid
}



proc renumber_water { sel segstart } {
	if { [$sel num] == 0 } {
		puts "Error in renumber: empty selection!"
		return
	}
    
    set newsegnames [list]
    set res  1
    set newresids [list]
    set postfix $segstart 

    lappend newsegnames W$postfix
    lappend newresids $res
    puts [format "segname:%s resid:%d" W$postfix $res]

    for { set i 1 } { $i < [$sel num] } { incr i } { 
        ### assign a new segname
        ### start over resid
        ### 9998 --> 9999 --> hexadecimal (10000)
        if { $i % 29997 == 0 } { 
            incr postfix
            set res 1
            puts [format "segname:%s resid:%d" W$postfix $res]
        } elseif { $i % 3 == 0}  {
            incr res
        }
        
    lappend newresids $res
    lappend newsegnames W$postfix 
    } 
    
    $sel set resid $newresids
    $sel set segname $newsegnames 

    puts [format "segname:%s resid:%d" W$postfix $res]
}



proc random { num } {return [expr {int(0 + rand() * $num)}]}

proc TIP3_to_ION { sel ion change } {
    set ions     [atomselect top "resname $ion"]
    set last_ion [lindex [$ions get resid] end]

    set resids   [$sel get resid]
    set uresids  [lsort -unique $resids]
    set nwaters  [llength $uresids]
    set remove   [list]

    for {set i 0} {$i < $change} {incr i} {
        set list_index [expr [random $nwaters]*3]
        #set list_index [expr $i*3]
        set resid [lindex $resids $list_index]
        set ion [atomselect top "index [$sel get index] and resid $resid and mass > 2"]
        $ion set resid [expr $last_ion + $i + 1]
        $ion set segname SOD
        $ion set resname SOD
        $ion set name SOD
        set others [atomselect top "index [$sel get index] and resid $resid and mass < 2"]
        lappend remove [lindex [$others get index] 0]
        lappend remove [lindex [$others get index] 1]
    }

    return $remove
}


proc sel_to_ndx { sel {group_name sel} {mode w} {ofile_name vmd.ndx} } {
    set file [open $ofile_name $mode]
    puts $file "\[ $group_name \]"
    set serial [$sel get serial]
    
    for {set i 0} {$i < [llength $serial]} {incr i} {
        puts -nonewline $file [format "%7d " [lindex $serial $i]]
        if { $i % 10 == 9 } { puts $file "" }
    }

    close $file
}


