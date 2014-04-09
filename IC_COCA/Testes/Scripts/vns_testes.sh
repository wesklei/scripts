#!/bin/bash

# FUNCTIONS_CODE=("0" "1" )
# FUNCTIONS=( "RASTRIGIN" "SCHAFFER_F7" )
# FUNCTIONS_CODE=( "2" "3" )
# FUNCTIONS=( "GRIEWANK" "ACKLEY" )
# FUNCTIONS_CODE=("4" "5" )
# FUNCTIONS=( "ROSENBROCK" "SPHERE" )
# FUNCTIONS_CODE=("6" )
# FUNCTIONS=( "MPE" )
# FUNCTIONS_CODE=( "7" "8")
# FUNCTIONS=( "SCHAFFER_F6" "G_SCHWEFELS")
# FUNCTIONS_CODE=("0" "1" "2" "3" "4" "5" "6" "7" "8")
# FUNCTIONS=( "RASTRIGIN" "SCHAFFER_F7" "GRIEWANK" "ACKLEY" "ROSENBROCK" "SPHERE" "MPE" "SCHAFFER_F6" "G_SCHWEFELS")
		# FUNCTIONS_CODE=("0" "1" "2" "3" "4" "5" "7" "8")
		# FUNCTIONS=( "RASTRIGIN" "SCHAFFER_F7" "GRIEWANK" "ACKLEY" "ROSENBROCK" "SPHERE" "SCHAFFER_F6" "G_SCHWEFELS")
# FUNCTIONS_CODE=("0")
# FUNCTIONS=( "RASTRIGIN" )
# 
# DIMENSIONS=("50")
DIMENSIONS=("50" "100" "150" "200" "250")

METHODS_CODE=("0" "1" "2" "3" "4")
METHODS=("RVNSM" "BVNSM" "HJ" "BVNS" "RVNS")
# METHODS=("VNS-HJ" "VNS" "HJ" "VNS-ONE-HJ" "VNS-SHAKE-ONE")

	echo "Creating dirs ..."
	echo "Generating input file ..."
	j=0;
	for m in "${METHODS[@]}"
	do
		i=0;
		for f in "${FUNCTIONS[@]}"
		do
			for d in "${DIMENSIONS[@]}"
			do
				mkdir -p $m/$f/$d
				cp input.in $m/$f/$d/
				cd $m/$f/$d/
				sed -i.bak s/DIMENSIONS/$d/g input.in
				rm input.in.bak
				sed -i.bak s/FUNCTIONS/${FUNCTIONS_CODE[$i]}/g input.in
				rm input.in.bak
				sed -i.bak s/METHODS/${METHODS_CODE[$j]}/g input.in
				rm input.in.bak
				cd ../../../
			done
			let i++;
		done
		let j++;
	done
	
	echo "Generation complete!"
	echo "Runing all ..."
	for m in "${METHODS[@]}"
	do
		for f in "${FUNCTIONS[@]}"
		do
			# for d in "${DIMENSIONS[@]}"
			# do
				# echo gnome-terminal -x sh -c "{ time ./alg $m/$f/$d/input.in > $m/$f/$d/output.out ; } 2>> $m/$f/$d/output.out ; sleep 10"
				gnome-terminal -x sh -c "{ time ./alg $m/$f/50/input.in > $m/$f/50/output.out ; } 2>> $m/$f/50/output.out ;"
				gnome-terminal -x sh -c "{ time ./alg $m/$f/100/input.in > $m/$f/100/output.out ; } 2>> $m/$f/100/output.out ;"
				gnome-terminal -x sh -c "{ time ./alg $m/$f/150/input.in > $m/$f/150/output.out ; } 2>> $m/$f/150/output.out ;"
				# time ./alg $m/$f/$d/input.in ;sleep 10000;
			# done
			#wait finish before run more testes
			while pgrep "alg" > /dev/null; do sleep 10; done
				gnome-terminal -x sh -c "{ time ./alg $m/$f/200/input.in > $m/$f/200/output.out ; } 2>> $m/$f/200/output.out ;"
				gnome-terminal -x sh -c "{ time ./alg $m/$f/250/input.in > $m/$f/250/output.out ; } 2>> $m/$f/250/output.out ;"
			while pgrep "alg" > /dev/null; do sleep 10; done
		done
	done
