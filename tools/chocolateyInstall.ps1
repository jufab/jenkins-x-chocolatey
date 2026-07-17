$checksum = "b4c56d02c667252682799eca0f73385d8b0ae92a4fbf06692193face83135138"
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
