$ErrorActionPreference = 'Stop';

$packageName = 'jenkins-x'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$url = 'https://github.com/jenkins-x/jx/releases/download/v1.2.79/jx-windows-amd64.zip'

$packageArgs = @{
  packageName    = $packageName
  url            = $url
  unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

if (Test-Path "$toolsPath\jx-windows*.zip") {
  $packageArgs2 = @{
    packageName    = $packageName
    url            = $url
    unzipLocation  = $toolsPath
  }
  Install-ChocolateyZipPackage @packageArgs2

  Remove-Item "$toolsPath\jx-windows*.zip"
}

Rename-Item -Path "$toolsPath\jx-windows-amd64.exe" -NewName "jx.exe"

Install-BinFile -Name "jx" -Path "$toolsPath"
