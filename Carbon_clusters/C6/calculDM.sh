#!/bin/bash
#############################################
# calculDM
#
# 2018.5.7
# LSPM/MP4/OR1/JM
#
#
#############################################
# Paramètres de calculs
#############################################
#Dimension de la grande boite de simulation
gmin=0      #A°
gmax=100    #A°
#
#Dimension de la petite boite de simulation
pmin=40      #A°
pmax=60    #A°
#
# Paramètres de simulations
timestep=0.0001     # ps
tempchauff=3000    # K
Tdamp=0.001
# Nombre d iterations 
iter=1000000000
iterther=1000000
# Export tous les iexports iterations
iexport=1000000
iexportim=1000000
#
#choix du seed des positions#
for i in $(seq 1 1 100)
do 
seed=$(sed -n $i"p" seed.txt)
echo $seed
#############################################
# Lancements des calculs
#############################################

export OMP_NUM_THREADS=2

#repd=`date '+%m%d%H%M%S'`
rep=$seed-$iter
mkdir ./cluster
mkdir ./cluster/$rep
mkdir ./cluster/$rep/dump
#
cp ./SRC/*.* ./cluster/$rep
# Lancement de Lammps
cd ./cluster/$rep
lmp -var iter $iter -var iterther $iterther -var iexport $iexport -var iexportim $iexportim -var timestep $timestep -var gmin $gmin -var gmax $gmax -var pmin $pmin -var pmax $pmax -var tempchauff $tempchauff -var Tdamp $Tdamp -var seed $seed < in.Carbon 
cd ../../
done