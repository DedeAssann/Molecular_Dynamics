# REBOII potentiel for c system
# .....

units		metal
boundary p p p	
atom_style	charge

############################################
#              CLI Variables               #
############################################
variable 		seed index 200093          #
variable 		N index 7                  #
variable 		iter index 1000000         #
variable 		iterther index 100000      #
variable 		iexport index 50000        #
variable 		tempchauf index 3000       #
variable 		Tdamp index 0.001          #
variable 		timestep index 0.0001      #
variable 		box_size index 10		   #
############################################
############################################

#----------------------- simulation box --------------------------------------------------	
lattice   sc 1.0
 
region     bigbox block 0 100 0 100 0 100
create_box     2 bigbox

region          smallbox block 40 60 40 60 40 60 units box
#region	        mysphere sphere 50.0 50.0 50.0 2.0 units box
	
create_atoms    1 random ${N} ${seed} smallbox

#create_atoms    1 random ${nbatoms} 268752 bigbox
mass * 12.0107

#----------------------- interaction potential -------------------------------------------
pair_style  airebo 1.7         
pair_coeff * * ./CH.airebo C	# see the file
neighbor	0.3 bin
neigh_modify    delay 0 every 1 check yes

velocity   all create  0.0001 1563967 rot yes dist gaussian

# ---------- Run MD CHAUFFE ---------------------
fix              2 all nve 
fix              3 all temp/berendsen 0.0 ${tempchauff} ${Tdamp}
fix              4 all momentum 1 linear 1 1 1 angular rescale


timestep	${timestep}


thermo ${iexport}
thermo_style custom step  temp etotal epair ebond pe ke

dump 		1 all cfg 100000 ./dump/dump.tensile_*.cfg mass type xs ys zs vx vy vz mass q

run		${iter}

write_restart endconf*1.restart

# ---------- Run MD ATTENTE ---------------------
unfix 3

thermo ${iexport}
thermo_style custom step  temp etotal epair ebond pe ke
fix             6 all temp/berendsen ${tempchauff} ${tempchauff} ${Tdamp}
run		${iterther}

write_restart endconf*2.restart

# ---------- Run MD REFROIDISSEMENT ---------------------
unfix 6

thermo ${iexport}
thermo_style custom step  temp etotal epair ebond pe ke
fix             7 all temp/berendsen ${tempchauff} 0.0 ${Tdamp}
run		${iter}
write_restart endconf*3.restart



