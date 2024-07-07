cls
echo "$((Get-Date).ToString('[HH:mm:ss]')) Started Tempcleaner"

function Remove-Files {
    param([string] $Path)

    try {
        Get-ChildItem -Path $Path -Recurse -ErrorAction Stop | ForEach-Object {
            try {
                Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop

                if (-not (Test-Path -Path $_.FullName)) {
                    echo "$((Get-Date).ToString('[HH:mm:ss]')) [SUCCESS] $($_.FullName)"
                } else {
                    echo "$((Get-Date).ToString('[HH:mm:ss]')) [FAIL   ] $($_.FullName)"
                }
            } catch {
                echo "$((Get-Date).ToString('[HH:mm:ss]')) [FAIL   ] $($_)" # - $_"
            }
        }
    } catch {
        echo "$((Get-Date).ToString('[HH:mm:ss]')) [FAIL   ] $($_)"
    }
}

Remove-Files -Path "$env:Temp\*"                                          # :: User-Temp
Remove-Files -Path "$env:SystemRoot\Temp\*"                               # :: System-Temp
Remove-Files -Path "$env:SystemRoot\SoftwareDistribution\Download\*"      # :: System-Update Temp
Remove-Files -Path "$env:SystemRoot\Prefetch"                             # :: System-Prefetch

echo ""

echo "$((Get-Date).ToString('[HH:mm:ss]')) Tempcleaner has cleaned %Temp%!"
echo "$((Get-Date).ToString('[HH:mm:ss]')) Tempcleaner has cleaned $env:SystemRoot\Temp!"
echo "$((Get-Date).ToString('[HH:mm:ss]')) Tempcleaner has cleaned $env:SystemRoot\SoftwareDistribution\Download!"
echo "$((Get-Date).ToString('[HH:mm:ss]')) Tempcleaner has cleaned $env:SystemRoot\Prefetch!"
pause
