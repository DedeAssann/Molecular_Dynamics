set crystal [atomselect top all]
$crystal set beta 0
set sel [atomselect top "resname LYS GLY"]
$sel set beta 1
$crystal delete
$sel delete