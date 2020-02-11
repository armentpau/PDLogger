function Remove-PDLogFile
{
	[CmdletBinding(ConfirmImpact = 'None',
				   SupportsShouldProcess = $true)]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$ScriptName,
		[string]$Path = 'c:\logs'
	)
	
	foreach ($item in Get-ChildItem "$($Path)\$($ScriptName)-[0-9]*.log")
	{
		try
		{
			Remove-Item $item.FullName -Force -ErrorAction Stop
		}
		catch
		{
			throw "There was an error removing $($item.FullName).  The error was $($psitem.tostring())"
		}
	}
}