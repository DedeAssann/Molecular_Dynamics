#============Initialization=================
units 			metal
atom_style 		atomic
boundary 		p p p

############################################
#              CLI Variables               #
############################################
variable 		seed index                 #
variable 		N index 8                  #
variable 		iter index 1.0e9           #
variable 		iterther index 1.0e6       #
variable 		iexport index 1.0e6        #
variable 		tempchauf index 3000       #
variable 		Tdamp index 0.001          #
variable 		timestep index 0.0001      #
############################################
############################################
#=========Simulation box definition=========
lattice 		sc 1.0
region 			bigbox block 0 100 0 100 0 100
create_box 		1 bigbox

#==================Atoms====================
region 			safezone block 40 60 40 60 40 60 units box
create_atoms 	1 random ${N} ${seed} safezone
labelmap 		atom 1 C
mass 			* 12.01



#==========Velocity initialization==========
velocity 		all create 0.0001 1563967 rot yes dist gaussian

#======Pair style for atom interactions=============
pair_style 		airebo 3.0
pair_coeff 		* * CH.airebo C

#==============Neighbor selection===================
neighbor 		0.3 bin
neigh_modify 	every 10 delay 0 check yes



#==============Custom Wall force====================
#==========Wall with harmonic potential=============
#variable       k equal 10.0

#fix             xlo_wall all wall/harmonic xlo EDGE v_k 1.0 0.7
#fix             xhi_wall all wall/harmonic xhi EDGE v_k 1.0 0.7
#fix             ylo_wall all wall/harmonic ylo EDGE v_k 1.0 0.7
#fix             yhi_wall all wall/harmonic yhi EDGE v_k 1.0 0.7
#fix             zlo_wall all wall/harmonic zlo EDGE v_k 1.0 0.7
#fix             zhi_wall all wall/harmonic zhi EDGE v_k 1.0 0.7



#=====================Timestep======================
timestep 		${timestep}

#===============Define dump command=================
dump 			1 all cfg 100000 ./dump/dump.tensile_*.cfg mass type xs ys zs vx vy vz id

#========System temperature printing info===========
thermo_style 	custom step temp etotal epair pe ke
thermo 			${iexport}	# 1'000'000



#====================CRC Cycle======================

#=============Condensation et chauffe===============

# Minimize during the heating phase
#min_style       sd
#minimize        1.0e-5 1.0e-7 500 1000

fix 			1 all nve
fix 			2 all temp/berendsen 0.0 ${tempchauff} ${Tdamp}
fix             3 all momentum 1 linear 1 1 1 angular rescale

run 			${iter}
write_restart 	./endconf/endconf*1.restart

#==============Constant Temp Phase==================

# Minimize during the constant temperature phase
min_style       sd
minimize        1.0e-5 1.0e-7 500 1000

unfix 			2
fix 			4 all temp/berendsen ${tempchauf} ${tempchauf} ${Tdamp}

run 			${iterther}
write_restart 	./endconf/endconf*2.restart

#=================Cooling Phase=====================

# Re-minimize before cooling
min_style       sd
minimize        1.0e-5 1.0e-7 500 1000

unfix 			4
fix 			5 all temp/berendsen ${tempchauff} 0.0 ${Tdamp}

run 			${iter}
write_restart 	./endconf/endconf*3.restart

