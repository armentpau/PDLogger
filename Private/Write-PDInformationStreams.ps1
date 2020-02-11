Function Write-PDInformationStreams
{
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[Object]$MessageData,
		[ConsoleColor]$ForegroundColor = $Host.UI.RawUI.ForegroundColor,
		[ConsoleColor]$BackgroundColor = $Host.UI.RawUI.BackgroundColor,
		[Switch]$NoNewline
	)
	
	$msg = [System.Management.Automation.HostInformationMessage]@{
		Message		    = $MessageData
		ForegroundColor = $ForegroundColor
		BackgroundColor = $BackgroundColor
		NoNewLine	    = $NoNewline.IsPresent
	}
	
	Write-Information $msg -InformationAction Continue
}