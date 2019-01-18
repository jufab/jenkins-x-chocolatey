$ErrorActionPreference = "Stop"
write-host "Attempting to stop any running jx processes, to allow upgrade"
try
{
  $running = get-process jx
}
catch
{
  write-host "No running jx processes to stop"
  $running = @()
}
 
if ($running)
{
  write-host "Stopping jx processes"
  foreach($p in $running)
  {
    stop-process $p
    write-verbose "Stopped $($p.ProcessName) $($p.Id)"
  }
}
