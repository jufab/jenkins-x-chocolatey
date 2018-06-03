$ErrorActionPreference = 'Stop';

$packageName = 'jenkins-x'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$version = $env:ChocolateyPackageVersion
$url = "https://github.com/jenkins-x/jx/releases/download/v$version/jx-windows-amd64.zip"
#1.2.98
$checksum = "ddf0a77ed2efd1ad03a6bfdc0fd305d6e1a6adc2be6c0cfc2861dff43879f88e" 
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
