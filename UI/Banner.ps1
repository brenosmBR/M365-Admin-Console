function Show-Banner {
    Clear-Host

    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "              Microsoft 365 Admin Console" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host (" {0,-14}: {1}" -f "Versão", "0.1.0")
    Write-Host (" {0,-14}: {1}" -f "Ambiente", "Development")
    Write-Host (" {0,-14}: {1}" -f "Branch", "feature/teams-auth")
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
}