function Show-Banner {
    Clear-Host

    # Tenta obter o nome da branch atual via Git de forma automática
    $CurrentBranch = git branch --show-current 2>$null
    if ([string]::IsNullOrWhiteSpace($CurrentBranch)) {
        $CurrentBranch = "N/A"
    }

    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "              Microsoft 365 Admin Console" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host (" {0,-14}: {1}" -f "Versão", "0.1.0")
    Write-Host (" {0,-14}: {1}" -f "Ambiente", "Development")
    Write-Host (" {0,-14}: {1}" -f "Branch", $CurrentBranch)
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
}