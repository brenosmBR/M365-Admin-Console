function Show-Banner {
    Clear-Host

    # Tenta obter o nome da branch atual via Git de forma automática
    $CurrentBranch = git branch --show-current 2>$null
    if ([string]::IsNullOrWhiteSpace($CurrentBranch)) {
        $CurrentBranch = "N/A"
    }

    # Leitura dinâmica das configurações a partir do config.json
    $ConfigPath = "$PSScriptRoot\..\Config\config.json"
    $Environment = "Development" # Valor padrão (fallback)
    $Version     = "0.1.0"       # Valor padrão (fallback)

    if (Test-Path $ConfigPath) {
        try {
            $Config = Get-Content -Path $ConfigPath -Raw | ConvertFrom-Json
            
            if ($Config.Environment) {
                $Environment = $Config.Environment
            }
            if ($Config.Application.Version) {
                $Version = $Config.Application.Version
            }
        } catch {
            # Caso falhe a leitura do JSON, mantém os valores padrão de fallback
        }
    }

    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "              Microsoft 365 Admin Console" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host (" {0,-14}: {1}" -f "Versão", $Version)
    Write-Host (" {0,-14}: {1}" -f "Ambiente", $Environment)
    Write-Host (" {0,-14}: {1}" -f "Branch", $CurrentBranch)
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
}