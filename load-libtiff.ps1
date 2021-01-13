param (
  [string] $version="4.2.0"
)

$fname  = "tiff-" + $version + ".zip"
$fname1 = "tiff-" + $version
$fname2 = "libtiff.zip"
$uri    = "https://download.osgeo.org/libtiff/$fname" 

$uri

Invoke-WebRequest -Uri $uri -OutFile $fname2 
& "C:\Program Files\7-Zip\7z" -aoa x $fname2 

Remove-Item $fname2
Rename-Item -Path $fname1 -NewName libtiff

