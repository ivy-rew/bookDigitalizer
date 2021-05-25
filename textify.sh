#!/bin/bash

capturePage(){
  gphoto2 --capture-image-and-download && mv -v capt0000.jpg $1
}

cutCrop(){
  camFile=$1
  file=$(basename "$camFile")
  echo "transform image $file"
  convert "$camFile" -rotate -90 -crop 2500x3400+650+1350 out_$camFile
}

ocrPage(){
  camFile=$1
  echo "OCR out_$camFile"
  tesseract -l deu out_$camFile $camFile
  cat $camFile.txt
}


textifyPage(){
  pageNo=$1
  img=$1.jpg
  capturePage $img
  cutCrop $img
  ocrPage $img
}

if [ "$1" -gt 0 ]; then
  textifyPage $1
fi
