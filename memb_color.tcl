source ~/Dropbox/scripts/memb.tcl

axes location off
display depthcue off
display ambientocclusion on
color Display Background white
display resize 1024 1024


# HIDE THE FIRST REP
mol showrep 0 0 off

color Segname HEAD 0
color Segname TAIL 1
color change rgb 0 0.430000 0.710000 1.000000
color change rgb 1 0.000000 0.430000 0.860000
color change rgb 2 0.140000 1.000000 0.140000

material add copy AOShiny # make a new material called Material23
material rename Material23 MEMB
material change ambient MEMB 0.15

# POPC/DOPE/SAPI
mol addrep 0 
mol modselect 1 0 "resname POPC or resname DOPE or resname SAPI"
mol modstyle 1 0 QuickSurf 0.800 0.500 0.500 3.00
mol modmaterial 1 0 MEMB
mol color Segname

# TRIO
mol addrep 0
mol modselect 2 0 "resname TRIO or resname CLOL"
mol modstyle  2 0 QuickSurf 0.800 0.500 0.500 3.00
mol modmaterial 2 0 MEMB
mol modcolor  2 0 ColorID 2

# PBC: EXPAND
#mol showperiodic 0 1 X
#mol numperiodic  0 1 1
#
#mol showperiodic 0 2 X
#mol numperiodic  0 2 1
#
#
## CUT
#set size [pbc get]
#set xlength [lindex $size 0 0]
#set ylength [lindex $size 0 1]
#set moveLipid [atomselect top "same residue as y < 80"]
#$moveLipid moveby [list 0 $ylength 0]
#
#rotate z by 180
#rotate x by 90
#scale by 1.5
#
display update on
