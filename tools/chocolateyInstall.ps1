$checksum = "139676c40509fb751c99498170f18996bb2a9f9a2145dd03ce3a2987a007bacf"
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
