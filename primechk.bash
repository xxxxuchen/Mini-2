#!/bin/bash
# Barry Chen, Department of Computer Science, McGill ID: 260952566

if [[ $# -gt 3 ]]
then
	echo wrong number of arguements
	exit 1
fi

if [[ "$3" = $NOSUCH ]] || [[ "$3" = "-l" ]]
then
	if [[ "$1" = "-f" ]] && [[ ! -f "$2" ]] && [[ "$3" = $NOSUCH ]] # check if -f followed by a real file
	then
		echo the file does not exist
		exit 2

	elif [[ "$1" = "-f" ]] && [[ -f "$2" ]] # if the usage is correct and the file exists
	then
		largest=0 
		for i in $(grep '^[123456789]' $2) # ensures that the there is no space in front of each number
		do
			if ( [[ $i -gt 1 ]] && [[ $i -lt 1000000000000000000 ]] ) 2> /dev/null # filter out the valid integer number, and throw out the message into /dev/null
			then 
				output=$(/home/2013/jdsilv2/206/mini2/primechk $i)
				if [[ "$output" = 'The number is a prime number.' ]] && [[ "$3" != "-l" ]]
				then
					echo $i # print each prime number when there is no -l argument
					
				elif [[ "$output" = 'The number is a prime number.' ]] && [[ "$3" = "-l" ]]
				then
					if [[ $i -gt $largest ]]
					then		
						largest=$i # keep updating the largest prime if there is an argument of -l in $3
					fi
				fi
			fi
		done
		if [[ "$3" != "-l" ]] # after looping,setting the exit code 
		then
			exit 0
		else # the situation that involves -l argumenet
			if [[ $largest -eq 0 ]] # this means the program cannot find a single prime number
			then
				echo not able to find any prime numbers
				exit 3
			else
				echo $largest
				exit 0
			fi
		fi
	fi
fi

if [[ "$1" = "-l" ]] && [[ "$2" = "-f" ]] && [[ ! -f "$3" ]]
then 
	echo the file does not exit
	exit 2
elif [[ "$1" = "-l" ]] && [[ "$2" = "-f" ]] && [[ -f "$3" ]] # this is another correct usage with valid input file
then
	largest=0
     	for i in $(grep '^[123456789]' $3) # same logic as above 
	do
		if [[ $i -gt 0 ]] 2> /dev/null
		then 
			output=$(/home/2013/jdsilv2/206/mini2/primechk $i)
			if [[ $output = 'The number is a prime number.' ]]
			then
				if [[ $i -gt $largest ]]
				then		
					largest=$i 
				fi
			fi
		fi
	done
	if [[ $largest -eq 0 ]]
	then 
		echo not able to find any prime numbers
		exit 3
	else
		echo $largest
		exit 0
	fi
fi

# all other usage that does not match the above if statements are considered as wrong usage
echo wrong usage
exit 1


