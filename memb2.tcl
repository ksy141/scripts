### HEAD
set head "name C11 C12 C13 C14 C15 C16 P N HP32 HP42 HP52 "
append head "OP32 OP33 OP34 OP42 OP43 OP44 OP52 OP53 OP54 "
append head "O11 O12 O13 O14 "
append head "C1 C2 C3 HA HB HC HR HS HT HX HY HZ "
for {set i 1} {$i < 5} {incr i} { append head "HN$i OC$i HO$i " }
for {set i 1} {$i < 7} {incr i} { append head "H1$i H$i H1${i}A H1${i}B H1${i}C " }
for {set i 2} {$i < 7} {incr i} { append head "O$i HO$i P$i " }

### GLYCEROL
set glycerol "name O21 O22 O31 O32 C21 C31 "

### TAILS
set tails	"name H91 H101 "
for {set i 2} {$i < 23} {incr i} { append tails "C2$i C3$i H${i}R H${i}S H${i}T H${i}X H${i}Y H${i}Z " }

### RENAME SEGMENT
set tails_sel [atomselect top "(resname DOPE or resname POPC or resname SAPI) and ($tails)"]
set heads_sel [atomselect top "(resname DOPE or resname POPC or resname SAPI) and ($head)"]
set glyce_sel [atomselect top "(resname DOPE or resname POPC or resname SAPI) and ($glycerol)"] 
$tails_sel set segname "TAIL"
$heads_sel set segname "HEAD"
$glyce_sel set segname "GLYC"


