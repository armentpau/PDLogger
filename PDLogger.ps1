<#
	.SYNOPSIS
		A brief description of the PDLogger.ps1 file.
	
	.DESCRIPTION
		A description of the file.
	
	.PARAMETER Path
		A description of the Path parameter.
	
	.PARAMETER Message
		A description of the Message parameter.
	
	.PARAMETER ScriptName
		A description of the ScriptName parameter.
	
	.PARAMETER Level
		A description of the Level parameter.
	
	.PARAMETER Start
		A description of the Start parameter.
	
	.PARAMETER End
		A description of the End parameter.
	
	.PARAMETER AppendUserName
		A description of the AppendUserName parameter.
	
	.PARAMETER AppendComputerName
		A description of the AppendComputerName parameter.
	
	.PARAMETER MirrorMessage
		A description of the MirrorMessage parameter.
	
	.PARAMETER MaxLogSize
		A description of the MaxLogSize parameter.
	
	.PARAMETER MaxLogs
		A description of the MaxLogs parameter.
	
	.PARAMETER DontRetainLogs
		A description of the DontRetainLogs parameter.
	
	.EXAMPLE
		PS C:\> .\PDLogger.ps1 -Message 'value1'
	
	.NOTES
		===========================================================================
		Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.154
		Created on:   	8/23/2018 9:59 PM
		Created by:   	PaulDeArment
		Organization:
		Filename:     	PDLogger.ps1
		===========================================================================
#>
param
(
	[Alias('FilePath', 'File')]
	[string]$Path,
	[Parameter(ParameterSetName = 'Default',
			   Mandatory = $true)]
	[ValidateNotNullOrEmpty()]
	[string]$Message,
	[Parameter(ParameterSetName = 'Default')]
	[string]$ScriptName,
	[Parameter(ParameterSetName = 'Default')]
	[ValidateSet('Information', 'Warning', 'Error', 'Debug', 'Verbose', IgnoreCase = $true)]
	[string]$Level = 'Information',
	[Parameter(ParameterSetName = 'Start')]
	[switch]$Start,
	[Parameter(ParameterSetName = 'End')]
	[switch]$End,
	[switch]$AppendUserName,
	[switch]$AppendComputerName,
	[switch]$MirrorMessage,
	[int]$MaxLogSize = 2 * 1MB,
	[int]$MaxLogs = 5,
	[switch]$DontRetainLogs
)
Import-Module AHCITModule

BEGIN
{
	if ($PSBoundParameters.ContainsKey("ScriptName"))
	{
		Write-Verbose "The paramter ScriptName contains the value $($ScriptName)"
	}
	else
	{
		if ((Get-Host).Version.Major -eq 2)
		{
			try
			{
				Write-Verbose "PowerShell Version 2 detected.  This version is depreciated.  You should update your version of PowerShell"
				$scriptName = (Split-Path $MyInvocation.ScriptName -Leaf).tolower().Replace('.ps1', '')
				Write-Verbose "Setting the value of scriptname value to $($ScriptName)"
			}
			catch
			{
				Write-Warning "Unable to determine script name.  Defaulting to Unknown."
				$scriptName = "Unknown"
			}
		}
		elseif ((get-host).Version.Major -eq 1)
		{
			Write-Warning "Version 1 of Powershell is not supported by this function.  Exiting function."
			exit
		}
		else #version greater than 2
		{
			Write-Verbose "PowerShell version detected is $((Get-Host).Version.Major).  Attempting to determine the script name."
			try
			{
				$scriptName = (Split-Path $MyInvocation.PSCommandPath -Leaf).tolower().Replace('.ps1', '')
				Write-Verbose "Setting scriptname variable to $($ScriptName)"
			}
			catch
			{
				$scriptName = "Unknown"
			}
		}
	}
	if ($ScriptName -eq "Unknown" -and ((get-process -Id $pid).name -ne "Powershell"))
	{
		$ScriptName = (Get-Process -Id $pid).name
	}
	if ($ScriptName -eq "Unknown")
	{
		Write-Warning "The script name is unknown.  Unable to determine the script name automatically."
	}
}
PROCESS
{

}
END
{

}