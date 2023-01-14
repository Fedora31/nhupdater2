#! /bin/sh

writevtx()
{
	dx80=$(echo output/0kb_files/$1 | sed 's/mdl$/dx80\.vtx/')
	dx90=$(echo output/0kb_files/$1 | sed 's/mdl$/dx90\.vtx/')

	mkdir -p $(dirname "$dx80")
	touch $dx80 $dx90
}

parse()
{
	modelname=$1
	filename=$2
	class=$3

	#if the file is specified as a vtx file, just create them
	if [ $filename = "vtx" ]; then
		writevtx $modelname
		return
	fi

	shift 3
	files="$@"
	modelname=$(echo $modelname | sed 's/^models\///')


	#create the qc files
	(
	cd output/uncompiled/$class
	echo "\$modelname	\"$modelname\"" > "$filename"
	cat $files >> "$filename"
	)
}

while read line; do
	parse $line
done < conf.txt
