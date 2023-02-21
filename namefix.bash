#!/bin/bash 
#Barry Chen, Department of Computer Science, McGill ID:260952566

curdir=$(pwd) 
inpath=$1
outpath=$2
infile=$(basename $inpath) # extract the input file name
dirname=$(dirname $outpath) # extract the path of directory, used later to check the write permission on the directory of output file

if [[ $# -ne 2 ]]
then 
	echo "you have put $# arguments, wrong number of arguments"
	exit 1
fi

if [[ ! -r "$1" ]] 
then	

	echo the input file is not readable or does not exists
	exit 3
fi

if [[ -f "$2" ]] && [[ ! -w "$2" ]] #check if the existing output file is able to be overwrited
then
	
	echo the existing ouput file is not writeable
	exit 4
fi

if [[ -d $2 ]]
then
	if [[ $curdir -ef $2 ]]
	then
		echo the output directory is same as the current directory
		exit 2
	elif [[ ! -x $2 ]] || [[ ! -w $2 ]]
	then
		echo the ouput directory is not writeable
		exit 4		
	else
		if [[ "$2" = /* ]] # the output dir is an absolute path
		then
			absolute=$2
			file=${absolute}/$infile # attach the file name after the absolute path
			if [[ -d $file ]] # ensure the path of the file that will be create is not an existing directory
			then
				echo "$file is a directory"
				exit 4
			else
				/home/2013/jdsilv2/206/mini2/namefix $1 $file
				exit 0
			fi
		else # it is a relative path
			relative=$2
			path=${curdir}/$relative #attach the relative path to the pwd path to create an absolute path
			file=${path}/$infile  #attach the file name after the absolute path that just created
			if [[ -d $file ]]
			then
				echo "$file is a directory"
				exit 4
			else
				/home/2013/jdsilv2/206/mini2/namefix $1 $file
        			exit 0
			fi
		fi
	fi       	
else # the ouput is file that waits to be created
	outfile=$(basename $outpath)
	if [[ $infile == $outfile ]]
	then
		echo input and ouput are same file	
		exit 2
	elif [[ ! -w $dirname ]] && [[ ! -f $2 ]] #check if the new created file has a writeable directory
	then
		echo do not have write permission on the output directory
		exit 4
	elif [[ ! -x $dirname ]] && [[ ! -f $2 ]] #check if the new created file has a executable directory
	then
		echo do not have execute permission on the output directory
		exit 4
	fi
fi

/home/2013/jdsilv2/206/mini2/namefix $1 $2 # no issue captured after all the checking
exit 0

