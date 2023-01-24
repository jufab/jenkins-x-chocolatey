$checksum = "76790dac58330246bb52decbbcb028aa266f7b21a5f4d0dc38a0cb3dfd1f3ac2"
$checksumtype = "sha256"
$packageName = 'jenkins-x'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$nuspecPath = Resolve-Path -Path $toolsPath+'\..'
[xml]$nuspecContent = Get-Content $nuspecPath\jenkins-x.nuspec
$version = $nuspecContent.package.metadata.version
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
