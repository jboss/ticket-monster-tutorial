#!/bin/bash

# Require BASH 3 or newer

REQUIRED_BASH_VERSION=3.0.0

if [[ $BASH_VERSION < $REQUIRED_BASH_VERSION ]]; then
  echo "You must use Bash version 3 or newer to run this script"
  exit
fi

# Canonicalise the source dir, allow this script to be called anywhere

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# DEFINE

TARGET=target/guides

OUTPUT_FORMATS=("xml" "epub" "pdf" "html")
OUTPUT_CMDS=("asciidoc -b docbook -o \${output_filename} \$file" "a2x -f epub -D \$dir \$file" "a2x --dblatex-opts \"-P latex.output.revhistory=0\" -D \$dir \$file" "asciidoc -b html5 -a toc2 -a pygments -o \${output_filename} \$file")

echo "** Building tutorial"

echo "**** Cleaning $TARGET"
rm -rf $TARGET
mkdir -p $TARGET

files=`find * -iname \*.asciidoc`

element_count=${#OUTPUT_FORMATS[@]}
for ((i=0; i <= $element_count; i++))
do
   output_format=${OUTPUT_FORMATS[i]}
   dir=$TARGET/$output_format
   mkdir -p $dir
   echo "**** Copying shared resources to $dir"
   cp -r gfx $dir

   for file in $files
   do
      output_filename=$dir/${file//.asciidoc/.$output_format}
      echo "**** Processing $file > ${output_filename}"
      eval ${OUTPUT_CMDS[i]}
   done

done

