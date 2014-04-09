
#!/bin/bash

	echo "Cleaning output files ..."
	rm *.out
	# for m in `ls | sort -h `; do
		# if [ -d "${m}" ]; then
			# rm ${m}_latex_table.out
			# touch ${m}_latex_table.out
		# fi
	# done
	echo "Opening directories ..."
	for m in `ls | sort -h `; do
		if [ -d "${m}" ]; then
#		 echo "${m}"   
			cd ${m}
			for f in `ls | sort -h `; do
				if [ -d "${f}" ]; then
#					 echo "${f}"   
					cd ${f}
					cd 250
							if [ -f output.out ]; then
								cat output.out | grep "Best solution found ==" | awk '{print $5}' >> ../../../${m}_${f}_boxplot.out
								
							fi
							cd ..
						# fi
					# done
					cd ..
					echo "${f}" >> ../data_boxplot.out
				fi
			done 
				cat ../data_boxplot.out | tr ' ' '\n'   | perl -ne 'chomp; print "$_ "; print "\n" if (!($. % 2)); END {print "\n"}' > ../${m}_${f}_func_data_boxplot.out
				rm ../data_boxplot.out
			
			for f in `ls | sort -h `; do
				if [ -d "${f}" ]; then
					 paste -d " " ../*_${f}_boxplot.out > ../${f}_data_boxplot.out
					 echo "paste -d " " ../*_${f}_boxplot.out > ../${f}_data_boxplot.out"
				fi
			done 
			cd ..
		fi
	done
