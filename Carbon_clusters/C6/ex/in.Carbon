# REBOII potentiel for c system
# .....

units		metal
boundary p p p	
atom_style	charge
variable seed index 200093
variable nbatoms index 8
variable tempchauff equal 3000
variable Tdamp equal 0.1
variable timestep equal 0.001
variable iexport equal 5000
variable iter equal 1000000000

#----------------------- simulation box --------------------------------------------------	
lattice   sc 1.0
 
region     bigbox block 0 100 0 100 0 100
create_box     2 bigbox

region          smallbox block 40 60 40 60 40 60 units box
#region	        mysphere sphere 50.0 50.0 50.0 2.0 units box
	
create_atoms    1 random ${nbatoms} ${seed} smallbox

mass * 12.0107

#----------------------- interaction potential -------------------------------------------
pair_style  rebo          
pair_coeff * * CH.rebo C C	# see the file
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

dump 		1 all cfg 1000000 ./dump/dump.tensile_*.cfg mass type xs ys zs vx vy vz mass q
#dump		2 all atom 1000000 tmp.dump

run		${iter}

write_restart endconf*1.restart

# ---------- Run MD ATTENTE ---------------------
unfix 3

thermo ${iexport}
thermo_style custom step  temp etotal epair ebond pe ke
fix             6 all temp/berendsen ${tempchauff} ${tempchauff} ${Tdamp}
run		100000 #${iterther}

write_restart endconf*2.restart

# ---------- Run MD REFROIDISSEMENT ---------------------
unfix 6

thermo ${iexport}
thermo_style custom step  temp etotal epair ebond pe ke
fix             7 all temp/berendsen ${tempchauff} 0.0 ${Tdamp}
run		${iter}
write_restart endconf*3.restart



