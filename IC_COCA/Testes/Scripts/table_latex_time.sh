#!/bin/bash

	echo "Cleaning output files ..."
	for m in `ls | sort -h `; do
		if [ -d "${m}" ]; then
			rm ${m}_latex_table.out
			touch ${m}_latex_table.out
		fi
	done
	echo "Opening directories ..."
	for m in `ls | sort -h `; do
		if [ -d "${m}" ]; then
#		 echo "${m}"   
			cd ${m}
			for f in `ls | sort -h `; do
				if [ -d "${f}" ]; then
#					 echo "${f}"   
					cd ${f}
					echo "${f}" >> ../../${m}_latex_table.out
					echo "${m}" >> ../../${m}_latex_table.out
					for d in `ls | sort -h `; do
						if [ -d "${d}" ]; then
#							 echo "${d}"   
							cd ${d}
							# echo "${d}" >> ../../../${m}_latex_table.out
							#best iter
							if [ -f output.out ]; then
								# best_iter=`cat output.out | grep "Iteration best:"`
								# best_iter="${best_iter//[^0-9 .]/}"
								#best fo
								# best_fo=`cat output.out | grep "FO best:"`
								# best_fo="${best_fo//[^0-9 .]/}"
								#mean
								#mean=`cat output.out | grep "FO mean: "`
								#mean="${mean//[^0-9.]/}"
								#deviation fo
								#dev_fo=`cat output.out | grep "FO Standard Deviation: "`
								#dev_fo="${dev_fo//[^0-9.]/}"
								#deviation iter
								# dev_it=`cat output.out | grep "Iteration Standard Deviation:"`
								# dev_it="${dev_it//[^0-9 .]/}"
								t_mean=`cat output.out | grep "Time mean: "`
								t_mean="${t_mean//[^0-9.]/}"
								t_dev_fo=`cat output.out | grep "Time Standard Deviation: "`
								t_dev_fo="${t_dev_fo//[^0-9.]/}"
								
								#if they are not empy
								#if [[ $mean && $dev_fo ]]; then
									# best_fo=`printf "%.2e" ${best_fo}`
									t_mean=`printf "%.2f" ${t_mean}`
									t_dev_fo=`printf "%.2f" ${t_dev_fo}`
								#fi
								line=" &${t_mean} \$\pm\$ ${t_dev_fo}"
								echo ${line} >> ../../../${m}_latex_table.out
							fi
							cd ..
						fi
					done
					cd ..
				fi
			done
			cd ..
		fi
	done
	cat *_latex_table.out >> table_format.tmp
	sed 's/_/\\_/g' table_format.tmp > table_format.out
	cat table_format.out | tr ' ' '\n'   | perl -ne 'chomp; print "$_ "; print "\n" if (!($. % 17)); END {print "\n"}' > table_format_2.out
	rm table_format.tmp
								
	# 		for d in "${DIMENSIONS[@]}"
	# 		do
	# 			mkdir -p $m/$f/$d
	# 			cp input.in $m/$f/$d/
	# 			cd $m/$f/$d/
	# 			sed -i.bak s/DIMENSIONS/$d/g input.in
	# 			rm input.in.bak
	# 			sed -i.bak s/FUNCTIONS/${FUNCTIONS_CODE[$i]}/g input.in
	# 			rm input.in.bak
	# 			sed -i.bak s/METHODS/${METHODS_CODE[$j]}/g input.in
	# 			rm input.in.bak
	# 			cd ../../../
	# 		done
	# 
	# echo "Generation complete!"
	# echo "Runing all ..."
	# for m in "${METHODS[@]}"
	# do
	# 	for f in "${FUNCTIONS[@]}"
	# 	do
	# 		for d in "${DIMENSIONS[@]}"
	# 		do
	# 			# echo gnome-terminal -x sh -c "{ time ./alg $m/$f/$d/input.in > $m/$f/$d/output.out ; } 2>> $m/$f/$d/output.out ; sleep 10"
	# 			# gnome-terminal -x sh -c "{ time ./alg $m/$f/$d/input.in > $m/$f/$d/output.out ; } 2>> $m/$f/$d/output.out ;"
	# 			time ./alg $m/$f/$d/input.in ;sleep 10000;
	# 		done
	# 	done
	# done
