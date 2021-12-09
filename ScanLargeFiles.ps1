param(
    
    [Parameter()]$Path = $(Get-Location),
    [Parameter()]$MinimimSize =1000000,
    [Parameter()]$ShowTotalBytes,
    [switch] $Help= $false)


if($Help -eq $true)
 {Write-Output("ScanLargeFiles.ps1
 Telt en toont het aantal files groter of gelijk aan dan de MinimumSize parameter, recursief geteld vanaf de meegegeven locatie in -Path.
 
 Parameters:
 -Help             toont deze Help informatie
 -Path             pad vanaf waar recursief scand wordt
 -MinimumSize      enkel files groter of gelijk aan de MinimumSize worden geteld
                   default value: 100000 bytes
 -ShowTotalBytes   toont eveneens het totale aantal bytes van de getelde files")}


try {
    $aantalGroteFiles = Get-ChildItem $Path -ErrorAction Stop| Where-Object Length -gt $MinimimSize  | Measure-Object 
    
}
catch {
   Write-Output "ERROR: ongeldig pad meegegeven"
}
$count = $aantalGroteFiles.Count
$totalBytes = Get-ChildItem | Where-Object -Property Length -ge $MinimimSize |Measure-Object -Property Length -sum
$ShowTotalBytes = $totalBytes.Sum

if (($Help -eq $false) -and ($Path -eq $true)){
 Write-Output "Je hebt $count grote file(s) in $Path"

}
 