$ErrorActionPreference = 'Stop';

$packageName = 'jenkins-x'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$version = $env:ChocolateyPackageVersion
$url = "https://github.com/jenkins-x/jx/releases/download/v$version/jx-windows-amd64.zip"
#1.2.95
$checksum = "7e8d98c778f75088196f49ba2e87db96e6c114b688bb57bdea18325155160f08" 
$checksumtype = "sha256" 

$packageArgs = @{
  packageName    = $packageName
  url            = $url
  unzipLocation  = $toolsPath
  checksum       = $checksum
  checksumtype   = $checksumtype
}
Install-ChocolateyZipPackage @packageArgs

if (Test-Path "$toolsPath\jx-windows*.zip") {
  $packageArgs2 = @{
    packageName    = $packageName
    url            = $url
    unzipLocation  = $toolsPath
    checksum       = $checksum
    checksumtype   = $checksumtype
  }
  Install-ChocolateyZipPackage @packageArgs2

  Remove-Item "$toolsPath\jx-windows*.zip"
}

Rename-Item -Path "$toolsPath\jx-windows-amd64.exe" -NewName "jx.exe"

Install-BinFile -Name "jx" -Path "$toolsPath"
