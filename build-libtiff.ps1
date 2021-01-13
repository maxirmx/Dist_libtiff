Param (
#  platform: either 'amd64' or 'x86'
#            'X64' is accepted as well and converted to 'amd64'
   [parameter(Mandatory=$false)][string]$platform="amd64",
#  platform: either 'debug' or 'release'
   [parameter(Mandatory=$false)][string]$configuration="debug",
# configure switch implies running vcvarsall.bat through CmdScript to inherit environment variables (local build)
   [parameter()][switch]$configure
)

 switch($platform) {
   "X64"   { $platform = "amd64"; break;  } 
   "x86"   { break; } 
   "amd64" { break; } 
   default { "build-libtiff.ps1: platform <" + $platform + "> was not recognized"; exit (-1);  } 
 }

 switch($configuration) {
   "release" { 
     $bp =  @("-x-", "-f", "Makefile.vc") 
     break; 
   } 
   "debug"   { 
     $bp =  @("-x-", "-f", "Makefile.vc", "DEBUG=1") 
     break; 
   } 
   default   { "build-libtiff.ps1: configuration <" + $configuration + "> was not recognized"; exit (-1);  } 
 }


 if ($configure) {
  .\EZTools\use-environment.ps1 "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" $platform
 } 

 $dname = Get-Location

 Set-Location "libtiff"
 & nmake $bp
 Set-Location $dname
