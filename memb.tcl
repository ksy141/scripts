
set head ""

set isFirst 1

for {set i 1} {$i < 7} {incr i} {
	if { $isFirst != 1 } {
		append head " or"	
	} else {
		set isFirst 0
	} 
	append head " name C1$i"
	
}

for {set i 1} {$i < 7} {incr i} {
	append head " or name H1$i or name H$i"	
}

for {set i 1} {$i < 5} {incr i} {
	append head " or name HN$i or name H$i"	
}

for {set i 1} {$i < 5} {incr i} {
	append head " or name OC$i or name HO$i"	
}
for {set i 1} {$i < 4} {incr i} {
	append head " or name O1$i"	
}
for {set i 2} {$i < 7} {incr i} {
	append head " or name O$i or name HO$i or name P$i"	
}
for {set i 2} {$i < 5} {incr i} {
	append head " or name OP3$i or name OP4$i or name OP5$i"	
}

append head " or name P or name N or name  HP32 or name HP42 or name HP52"

puts $head


set glycerol "name C1 or name C2 or name C3 or name HA or name HB or name HC or name HR or name HS or name HT or name HX or name HY or name HZ"


set tails	"name O21 or name O22 or name O31 or name O32"

set r "R"
set s "S"
set t "T"
set x "X"
set y "Y"
set z "Z"


for {set i 1} {$i < 23} {incr i} {
	append tails " or name C2$i or name H$i$r or name H$i$s or name H$i$t"
		
}

for {set i 1} {$i < 23} {incr i} {
	append tails " or name C3$i or name H$i$x or name H$i$y or name H$i$z"
		
}


### ADDED BY SIYOUNG
for {set i 1} {$i < 6} {incr i} {
    append head " or name H1${i}A or name H1${i}B or name H1${i}C"
}
append head " or name O14"

append tails " or name H91 or name H101"
###


set tails_sel [atomselect top "(resname DOPE or resname POPC or resname SAPI) and ($tails)"]
set heads_sel [atomselect top "(resname DOPE or resname POPC or resname SAPI) and (($head) or ($glycerol))"]

$tails_sel set segname "TAIL"
$heads_sel set segname "HEAD"


