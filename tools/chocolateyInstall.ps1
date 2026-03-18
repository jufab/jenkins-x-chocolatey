$checksum = "25b145ee7cfc196c0d132be984125d2fd04db7b69a45a5e0df71b4ae0df1d321"
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
