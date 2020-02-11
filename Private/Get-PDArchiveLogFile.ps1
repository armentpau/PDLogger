function Get-PDAHCArchiveLogFile
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[int]$MaxLogs,
		[Parameter(Mandatory = $true)]
		[string]$ScriptName,
		[string]$Path = 'c:\logs'
	)
	
	$fileNotFoundFlag = 0
	$logFile = $null
	foreach ($item in (1 .. $($MaxLogs)))
	{
		if (-not (Test-Path "$($Path)\$($ScriptName)-$([int]($item)).log") -and $fileNotFoundFlag -eq 0)
		{
			$fileNotFoundFlag = 1
			$logFile = "$($Path)\$($ScriptName)-$([int]($item)).log"
		}
	}
	if ($fileNotFoundFlag -eq 0)
	{
		Rename-PDLogFile -MaxLogs $MaxLogs -ScriptName $ScriptName -Path $Path
		$logFile = Get-PDAHCArchiveLogFile -MaxLogs $MaxLogs -ScriptName $ScriptName -Path $Path
	}
	return $logFile
}