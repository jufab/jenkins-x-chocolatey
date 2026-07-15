$checksum = "4b1c9aa432c8ec4e261a685b751b3910b424cd9a1a03066f83640c1a9512fa72"
$checksumtype = "sha256"
$packageName = 'jenkins-x'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$version = $env:ChocolateyPackageVersion
$fileZip = "jx-windows-amd64.zip"
$url = "https://github.com/jenkins-x/jx/releases/download/v$version/$fileZip"

if (Test-Path "$toolsPath\jx.exe") {
  Remove-Item "$toolsPath\jx.exe"
  Uninstall-BinFile -Name "jx" -Path "$toolsPath"
}
$packageArgs = @{
  packageName    = $packageName
  url            = $url
  unzipLocation  = $toolsPath
  checksum       = $checksum
  checksumtype   = $checksumtype
}
Install-ChocolateyZipPackage @packageArgs
Remove-Item "$toolsPath\jx-windows*.zip"
Install-BinFile -Name "jx" -Path "$toolsPath"
