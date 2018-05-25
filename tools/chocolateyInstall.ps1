$ErrorActionPreference = 'Stop';

$packageName = 'jenkins-x'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$version = $env:ChocolateyPackageVersion
$url = "https://github.com/jenkins-x/jx/releases/download/v$version/jx-windows-amd64.zip"
#1.2.77
$checksum = "697e7dee87a39ace4c374f3a8dd8c830435b8f0e27c95778c559366d6aeb34f1" 
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
