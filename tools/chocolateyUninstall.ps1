$ErrorActionPreference = 'Stop';

$packageName = 'jenkins-x'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

Uninstall-BinFile -Name "jx" -Path "$toolsPath"
