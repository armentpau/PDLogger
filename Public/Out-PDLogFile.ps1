<#
	.SYNOPSIS
		A brief description of the Out-PDLogFile function.
	
	.DESCRIPTION
		A detailed description of the Out-PDLogFile function.
	
	.PARAMETER Message
		A description of the Message parameter.
	
	.PARAMETER MessageType
		A description of the MessageType parameter.
	
	.PARAMETER Start
		A description of the Start parameter.
	
	.PARAMETER End
		A description of the End parameter.
	
	.PARAMETER MaxLogSize
		The max log size that should be generated, in MB
	
	.PARAMETER MaxLogs
		The max number of log files that should be retained.
	
	.PARAMETER NoLogRetention
		A description of the NoLogRetention parameter.
	
	.PARAMETER Path
		A description of the Path parameter.
	
	.PARAMETER AppendUsername
		A description of the AppendUsername parameter.
	
	.PARAMETER MirrorMessage
		A description of the MirrorMessage parameter.
	
	.PARAMETER ScriptName
		A description of the ScriptName parameter.
	
	.EXAMPLE
		PS C:\> Out-PDLogFile -Message 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Out-PDLogFile
{
	[CmdletBinding(DefaultParameterSetName = 'Message',
				   PositionalBinding = $true)]
	param
	(
		[Parameter(ParameterSetName = 'Message',
				   Mandatory = $true,
				   ValueFromPipeline = $true,
				   ValueFromPipelineByPropertyName = $false,
				   Position = 0)]
		[string]$Message,
		[Parameter(ParameterSetName = 'Message',
				   Mandatory = $false,
				   Position = 1)]
		[ValidateSet('Information', 'Warning', 'Error', 'PipelineData', 'Exception', 'Verbose', IgnoreCase = $true)]
		[Alias('Type', 'MT', 'Level')]
		[string]$MessageType,
		[Parameter(ParameterSetName = 'Start',
				   Mandatory = $false)]
		[switch]$Start,
		[Parameter(ParameterSetName = 'End',
				   Mandatory = $false)]
		[switch]$End,
		[Parameter(Mandatory = $false)]
		[ValidateNotNullOrEmpty()]
		[int]$MaxLogSize = 2,
		[ValidateNotNullOrEmpty()]
		[int]$MaxLogs = 10,
		[switch]$NoLogRetention,
		[ValidateNotNullOrEmpty()]
		[string]$Path = 'c:\logs',
		[switch]$AppendUsername,
		[switch]$MirrorMessage,
		[String]$ScriptName
	)
	
	BEGIN
	{
		#setting the max log sinze in MB
		$MaxLogSizeMB = $MaxLogSize * 1MB
		
		if ([string]::IsNullOrEmpty($ScriptName))
		{
			if ((get-host).Version.Major -eq 2)
			{
				try
				{
					$ScriptName = (Split-Path $MyInvocation.ScriptName -Leaf -ErrorAction stop).tolower().replace('.ps1','')
				}
				catch
				{
					$ScriptName = "Unknown"
				}
			}
			else
			{
				try
				{
					$ScriptName = (Split-Path $MyInvocation.PSCommandPath -Leaf -ErrorAction stop).tolower().replace('.ps1', '')
				}
				catch
				{
					$ScriptName = "Unknown"
				}
			}
			if ($ScriptName -eq "Unknown" -and ((Get-Process -Id $PID).name -ne "PowerShell"))
			{
				$ScriptName = (Get-Process -Id $PID).name
			}
			if ($ScriptName -eq "Unknown")
			{
				Write-Warning "Unable to determine script name.  Defaulting to Unknown."
			}
			if ($AppendUsername)
			{
				$ScriptName = "$($env:USERNAME)_$($ScriptName)"
			}
			if (-not (Test-Path "$($Path)"))
			{
				try
				{
					New-Item -Path "$($Path)" -ItemType directory -ErrorAction Stop
				}
				catch
				{
					Write-Warning "There was an error creating $($Path).  The error was $($psitem.tostring())"
				}
				
			}
		}
		
	}
	PROCESS
	{
	}
	END
	{
	}
}